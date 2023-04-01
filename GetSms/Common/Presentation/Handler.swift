//
//  Handler.swift
//  GetSms
//
//  Created by Роман Ломтев on 26.03.2023.
//

protocol Handler: AnyObject {
    
    associatedtype Intent
    
    func handle(intent: Intent)
}
