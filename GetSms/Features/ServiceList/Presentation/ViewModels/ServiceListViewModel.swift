//
//  ServiceListViewModel.swift
//  GetSms
//
//  Created by Роман Ломтев on 25.03.2023.
//

import SwiftUI

class ServiceListViewModel: ObservableObject {
    
    typealias State = ServiceListState
    typealias Intent = ServiceListIntent
    
    // MARK: - External vars
    @Published var state: ServiceListState = .Idle
    
    // MARK: - Internal vars
    private let reducer: ServiceListReducer = ServiceListReducer()
    
    private class ServiceListReducer: Reducer {
        
        func reduce(currentState: State, intent: Intent) -> State {
            switch(intent) {
                
            case .LoadList:
                return .Loading
                
            case .ShowList:
                return .Loaded
            }
        }
    }
}

extension ServiceListViewModel: Processor {
    
    func subscribeToIntents() {
        
    }
    
    func handleIntent(intent: Intent, state: State) -> Intent? {
        
        switch(intent) {
            
        case .LoadList:
            return nil
            
        case .ShowList:
            return nil
        }
    }
}

