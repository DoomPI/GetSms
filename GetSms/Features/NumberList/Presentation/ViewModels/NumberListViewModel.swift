//
//  NumberListViewModel.swift
//  GetSms
//
//  Created by Роман Ломтев on 16.04.2023.
//

import SwiftUI

protocol NumberListHandlerProtocol: Handler where Intent == NumberListIntent {
}

class NumberListViewModel: ObservableObject {
    
    typealias State = NumberListState
    
    // MARK: - External vars
    @Published private(set) var state: State = .Loading()
    
    // MARK: - Internal vars
    private let processor: any NumberListProcessorProtocol
    private let reducer: any NumberListReducerProtocol
    
    // MARK: - Init
    init(
        processor: any NumberListProcessorProtocol,
        reducer: any NumberListReducerProtocol
    ) {
        self.processor = processor
        self.reducer = reducer
    }
    
    func onViewAppear() {
        processor.subscribeToIntents()
    }
    
    func loadNumberList(
        numbersDisplayedCount: Int? = nil
    ) {
        processor.fireIntent(intent: .LoadList(numbersDisplayedCount: numbersDisplayedCount))
    }
    
    func cancelNumber(numberId: String) {
        processor.fireIntent(intent: .CancelNumber(numberId: numberId))
    }
}

extension NumberListViewModel: NumberListHandlerProtocol {
    
    func handle(intent: NumberListIntent) {
        let newState = self.reducer.reduce(
            currentState: state,
            intent: intent
        )
        self.state = newState
    }
}
