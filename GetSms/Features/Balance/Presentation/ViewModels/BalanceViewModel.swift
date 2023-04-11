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
    
    // MARK: - External vars
    @Published private(set) var state: State = .Loading
    
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
}

extension BalanceViewModel: BalanceHandlerProtocol {
    
    func handle(intent: BalanceIntent) {
        let newState = self.reducer.reduce(currentState: state, intent: intent)
        self.state = newState
    }
}
