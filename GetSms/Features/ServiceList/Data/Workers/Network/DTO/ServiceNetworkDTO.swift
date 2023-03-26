//
//  ServiceNetworkDTO.swift
//  GetSms
//
//  Created by Роман Ломтев on 26.03.2023.
//

struct ServiceNetworkDTO: Decodable {
    let name: String
    let imageURL: String
    let quantity: Int
    let info: String?
    let cost: Float
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case imageURL = "icon"
        case quantity = "quantity"
        case info = "info"
        case cost = "cost"
    }
}
