import Foundation

struct Place: Decodable {
    
    let documents: [Contents]
}

struct Contents: Decodable {
    let place_name: String
    let address_name: String
    let distance: String
}
