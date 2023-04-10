//
//  BalanceDTO.swift
//  GetSms
//
//  Created by Роман Ломтев on 10.04.2023.
//

struct BalanceNetworkDTO: Decodable {
    let balance: Float?
    
    enum CodingKeys: String, CodingKey {
        case balance = "balance"
    }
}
