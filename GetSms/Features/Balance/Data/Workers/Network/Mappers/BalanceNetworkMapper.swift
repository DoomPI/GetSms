//
//  BalanceNetworkMapper.swift
//  GetSms
//
//  Created by Роман Ломтев on 10.04.2023.
//

import Foundation

class BalanceNetworkMapper {

    func fromDto(dto: BalanceNetworkDTO) throws -> Balance {
        guard
            let balance = dto.balance
        else {
            throw NSError(domain: "BalanceNetworkMapper", code: 1)
        }
        
        return Balance(
            balance: balance
        )
    }
}
