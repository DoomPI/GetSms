//
//  BalanceFormatter.swift
//  GetSms
//
//  Created by Роман Ломтев on 10.04.2023.
//

class BalanceFormatter {
    
    func format(model: Balance) -> BalanceVO {
        let balance = String(format: "%.2f ₽", model.balance)
        
        return BalanceVO(balance: balance)
    }
}
