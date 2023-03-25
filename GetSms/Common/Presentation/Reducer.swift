//
//  Reducer.swift
//  GetSms
//
//  Created by Роман Ломтев on 25.03.2023.
//

protocol Reducer {
    
    associatedtype State
    associatedtype Intent
    
    func reduce(currentState: State, intent: Intent) -> State
}
