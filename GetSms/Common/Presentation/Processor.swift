//
//  Processor.swift
//  GetSms
//
//  Created by Роман Ломтев on 25.03.2023.
//

protocol Processor {
    
    associatedtype Intent
    
    func subscribeToIntents()
    
    func fireIntent(intent: Intent)
}
