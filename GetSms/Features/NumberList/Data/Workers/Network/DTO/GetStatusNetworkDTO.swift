//
//  StatusNetworkDTO.swift
//  GetSms
//
//  Created by Роман Ломтев on 19.04.2023.
//

struct GetStatusNetworkDTO: Decodable {
    let status: String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
    }
}
