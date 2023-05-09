//
//  PaymentIntent.swift
//  GetSms
//
//  Created by Роман Ломтев on 11.04.2023.
//

enum PaymentIntent {
    
    case Nothing
    
    case Open
    
    case Close
    
    case Error(message: String)
    
    case Active
}
