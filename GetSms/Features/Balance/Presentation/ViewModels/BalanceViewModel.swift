//
//  BalanceViewModel.swift
//  GetSms
//
//  Created by Роман Ломтев on 10.04.2023.
//

import SwiftUI

protocol BalanceHandlerProtocol: Handler where Intent == BalanceIntent {
}

class BalanceViewModel: ObservableObject {
    
    typealias State = BalanceState
    typealias RouteState = BalanceRouteState
    
    // MARK: - External vars
    @Published private(set) var state: State = .Loading
    
    @Published private(set) var routeState: RouteState = .Idle
    
    // MARK: - Internal vars
    private let processor: any BalanceProcessorProtocol
    private let reducer: any BalanceReducerProtocol
    
    // MARK: - Init
    init(
        processor: any BalanceProcessorProtocol,
        reducer: any BalanceReducerProtocol
    ) {
        self.processor = processor
        self.reducer = reducer
    }
    
    func onViewAppear() {
        processor.subscribeToIntents()
    }
    
    func proceedToPayment() {
        processor.fireIntent(intent: .ProceedToPayment)
    }
    
    func reloadBalance() {
        processor.fireIntent(intent: .Load)
    }
    
    func logout() {
        processor.fireIntent(intent: .Logout)
    }
}

extension BalanceViewModel: BalanceHandlerProtocol {
    
    func handle(intent: BalanceIntent) {
        let newState = self.reducer.reduce(currentState: state, intent: intent)
        self.state = newState
        
        switch intent {
            
        case .ProceedToPayment:
            self.routeState = .PaymentRouting
            
        case .ProceedToAuth:
            self.routeState = .AuthRouting
            
        default:
            self.routeState = .Idle
        }
    }
}
