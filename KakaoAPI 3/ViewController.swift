import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var dataList: [Contents] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        getCoffeeStoreInformation()
    }
    
    let url: String = "https://dapi.kakao.com/v2/local/search/keyword.json?query=%EC%BB%A4%ED%94%BC&size=15&x=126.999398337486&y=37.5032064667979&radius=10000"
    
    func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func getCoffeeStoreInformation() {
        
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("KakaoAK d8b066a3dbb0e888b857f37b667d96d2", forHTTPHeaderField: "Authorization")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else { return }
            guard let response = response as? HTTPURLResponse else { return }
            guard error == nil else { return }
            
            switch response.statusCode {
            case 200:
                let data = try? JSONDecoder().decode(Place.self, from: data)
                
                if let data = data {
                    self.dataList = data.documents
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            default:
                print("데이터 연결 실패")
            }
        }
        dataTask.resume()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell" , for: indexPath) as? MyCell else { return UITableViewCell() }
        
        let contents = dataList[indexPath.row]
        cell.storeLabel.text = contents.place_name
        cell.addressLabel.text = contents.address_name
        cell.distanceLabel.text = contents.distance
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
