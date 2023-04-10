//
//  BalanceNetworkMapper.swift
//  GetSms
//
//  Created by Роман Ломтев on 10.04.2023.
//

class BalanceNetworkMapper {

    func fromDto(dto: BalanceNetworkDTO) -> Balance {
        let balance = dto.balance!
        
        return Balance(
            balance: balance
        )
    }
}
