//
//  AuthState.swift
//  GetSms
//
//  Created by Роман Ломтев on 09.04.2023.
//

enum AuthState {
    
    case Idle
    
    case BlockingLoading
    
    case SuccessfulAuth(vo: AuthVO)
    
    case FailedAuth
}
