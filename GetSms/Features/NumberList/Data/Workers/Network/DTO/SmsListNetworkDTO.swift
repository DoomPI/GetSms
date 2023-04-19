//
//  SmsListNetworkDTO.swift
//  GetSms
//
//  Created by Роман Ломтев on 15.04.2023.
//

struct SmsListNetworkDTO: Decodable {
    let data: [String]?
    let error: String?
    
    enum CodingKeys: String, CodingKey {
        case data = "smsCode"
        case error = "error"
    }
}
