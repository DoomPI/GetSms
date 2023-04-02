//
//  CountryNetworkDTO.swift
//  GetSms
//
//  Created by Роман Ломтев on 01.04.2023.
//

struct CountryNetworkDTO: Decodable {
    let name: String?
    let imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case imageURL = "icon"
    }
}

