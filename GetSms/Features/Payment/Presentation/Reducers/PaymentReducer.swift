//
//  PaymentReducer.swift
//  GetSms
//
//  Created by Роман Ломтев on 11.04.2023.
//

protocol PaymentReducerProtocol: Reducer where State == PaymentState, Intent == PaymentIntent {
}

class PaymentReducer {
}

extension PaymentReducer: PaymentReducerProtocol {
    
    func reduce(currentState: State, intent: Intent) -> State {
        switch intent {
            
        case .Nothing:
            return currentState
            
        case .Open:
            return .Opened
            
        case .Close:
            return .Closed
            
        }
    }
}
