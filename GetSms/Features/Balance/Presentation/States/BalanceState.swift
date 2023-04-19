//
//  BalanceState.swift
//  GetSms
//
//  Created by Роман Ломтев on 10.04.2023.
//

enum BalanceState {
    
    case Loading
    
    case Loaded(vo: BalanceVO)
    
    case Error
    
}
