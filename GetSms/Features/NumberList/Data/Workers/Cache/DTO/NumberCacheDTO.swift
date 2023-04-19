//
//  NumberCacheDTO.swift
//  GetSms
//
//  Created by Роман Ломтев on 15.04.2023.
//

struct NumberCacheDTO: Codable {
    let serviceName: String?
    let id: String?
    let phoneNumber: Int?
    
    enum CodingKeys: String, CodingKey {
        case serviceName = "serviceName"
        case id = "id"
        case phoneNumber = "phoneNumber"
    }
}
