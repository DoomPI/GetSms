//
//  Processor.swift
//  GetSms
//
//  Created by Роман Ломтев on 25.03.2023.
//

protocol Processor {
    
    associatedtype State
    associatedtype Intent
    
    func subscribeToIntents()
    
    func handleIntent(intent: Intent, state: State) -> Intent?
}
