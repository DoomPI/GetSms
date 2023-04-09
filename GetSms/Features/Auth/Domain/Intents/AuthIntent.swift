//
//  AuthIntent.swift
//  GetSms
//
//  Created by Роман Ломтев on 09.04.2023.
//

enum AuthIntent {
    
    case None
    
    case BlockingLoad
    
    case Success(model: AuthModel)
    
    case Failure
}
