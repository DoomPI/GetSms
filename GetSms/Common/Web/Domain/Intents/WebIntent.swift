//
//  WebViewNavigationAction.swift
//  GetSms
//
//  Created by Роман Ломтев on 02.04.2023.
//

enum WebIntent {
    
    case None
    
    case Forward
    
    case Backward
    
    case Reload
    
    case Error(message: String)
}
