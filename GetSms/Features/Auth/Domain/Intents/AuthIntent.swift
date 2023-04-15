//
//  AuthIntent.swift
//  GetSms
//
//  Created by Роман Ломтев on 09.04.2023.
//

enum AuthIntent {
    
    case ShowAuth
    
    case BlockingLoad
    
    case Success
    
    case Failure
    
    case SaveApiKey(apiKey: ApiKey)
    
    case CheckApiKey
}
