//
//  NumberNetworkDTO.swift
//  GetSms
//
//  Created by Роман Ломтев on 15.04.2023.
//

struct NumberNetworkDTO: Decodable {
    let id: String
    let phoneNumber: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "idNum"
        case phoneNumber = "tel"
    }
}
