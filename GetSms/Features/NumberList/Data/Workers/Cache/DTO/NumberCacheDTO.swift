//
//  NumberCacheDTO.swift
//  GetSms
//
//  Created by Роман Ломтев on 15.04.2023.
//

struct NumberCacheDTO: Codable {
    let id: String?
    let phoneNumber: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case phoneNumber = "phoneNumber"
    }
}
