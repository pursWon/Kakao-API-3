import Foundation

struct Place: Decodable {
    
    let documents: [Contents]
}

struct Contents: Decodable {
    let place_name: Stringㅌㅁ
    let address_name: String
    let distance: String
}
