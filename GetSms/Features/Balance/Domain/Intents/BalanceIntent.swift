//
//  BalanceIntent.swift
//  GetSms
//
//  Created by Роман Ломтев on 10.04.2023.
//

enum BalanceIntent {
    
    case Load
    
    case PresentBalance(model: Balance)
    
    case PresentError
    
    case ProceedToPayment
}
