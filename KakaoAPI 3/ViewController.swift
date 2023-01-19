import UIKit
import Alamofire


class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var dataList: [Contents] = []
    var placeList: [Contents] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        alamoFire2(url: url)
    }
    
    let url: String = "https://dapi.kakao.com/v2/local/search/keyword.json"
    
    func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // func alamofire(url: String) {
    //     let headers: HTTPHeaders = [
    //         "Authorization" : "KakaoAK d8b066a3dbb0e888b857f37b667d96d2"
    //     ]
    //
    //     let parameters: [String : Any] = [
    //         "query" : "해장국"
    //     ]
    //
    //     AF.request(url, method: .get, parameters: parameters,headers: headers)
    //         .validate(statusCode: 200..<300)
    //         .responseData { response in
    //             switch response.result {
    //             case .success(let data):
    //                 print("success: \(data)")
    //                 let placeData = try? JSONDecoder().decode(Place.self, from: data)
    //                 if let placeData = placeData {
    //                     self.placeList = placeData.documents
    //                     print(self.placeList[0].place_name)
    //                     DispatchQueue.main.async {
    //                         self.tableView.reloadData()
    //                     }
    //                 }
    //
    //             case .failure(let error):
    //                 print("failure: \(error)")
    //             }
    //         }
    // }
    
    func alamoFire2(url: String) {
        let headers: HTTPHeaders = [
            "Authorization" : "KakaoAK d8b066a3dbb0e888b857f37b667d96d2"
        ]
        
        let parameters: [String : Any] = [
            "query" : "장칼국수"
        ]
        
        AF.request(url, method: .get, parameters: parameters, headers: headers).responseDecodable(of: Place.self) { response in
            debugPrint(response)
            print(response.value)
            
            if let data = response.value {
                self.placeList = data.documents
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell" ,for: indexPath) as? MyCell else { return UITableViewCell() }
        
        let contents = placeList[indexPath.row]
        cell.storeLabel.text = contents.place_name
        cell.addressLabel.text = contents.address_name
        cell.distanceLabel.text = contents.distance
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
