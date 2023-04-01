//
//  CountryNetworkDTO.swift
//  GetSms
//
//  Created by Роман Ломтев on 01.04.2023.
//

struct CountryNetworkDto: Decodable {
    let name: String?
    let icon: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case icon = "icon"
    }
}
