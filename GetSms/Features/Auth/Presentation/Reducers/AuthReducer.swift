//
//  AuthReducer.swift
//  GetSms
//
//  Created by Роман Ломтев on 09.04.2023.
//

protocol AuthReducerProtocol: Reducer where State == AuthState, Intent == AuthIntent {
}

class AuthReducer {
}

extension AuthReducer: AuthReducerProtocol {
    
    func reduce(currentState: State, intent: Intent) -> State {
        switch intent {
            
        case .Nothing:
            return currentState
            
        case .BlockingLoad:
            return .BlockingLoading
            
        case .Success:
            return .SuccessfulAuth
            
        case .Failure:
            return .FailedAuth

        }
    }
}
