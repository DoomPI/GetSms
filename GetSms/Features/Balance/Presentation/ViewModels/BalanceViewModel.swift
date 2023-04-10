//
//  BalanceViewModel.swift
//  GetSms
//
//  Created by Роман Ломтев on 10.04.2023.
//

import SwiftUI
import RxSwift

protocol BalanceHandlerProtocol: Handler where Intent == BalanceIntent {
}

class BalanceViewModel: ObservableObject {
    
    typealias State = BalanceState
    
    // MARK: - External vars
    @Published private(set) var state: State = .Loading
    
    // MARK: - Internal vars
    private let processor: any BalanceProcessorProtocol
    private let reducer: any BalanceReducerProtocol
    private let interactor: BalanceBusinessLogic
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    init(
        processor: any BalanceProcessorProtocol,
        reducer: any BalanceReducerProtocol,
        interactor: BalanceBusinessLogic
    ) {
        self.processor = processor
        self.reducer = reducer
        self.interactor = interactor
    }
    
    func onViewAppear() {
        processor.subscribeToIntents()
    }
}

extension BalanceViewModel: BalanceHandlerProtocol {
    
    func handle(intent: BalanceIntent) {
        let newState = self.reducer.reduce(currentState: state, intent: intent)
        self.state = newState
        
        switch intent {
            
        case .Load:
            interactor
                .getBalance()
                .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
                .observe(on: MainScheduler.instance)
                .subscribe(
                    onSuccess: { [weak self] balance in
                        self?.processor.fireIntent(intent: .PresentBalance(model: balance))
                    },
                    onFailure: { [weak self] _ in
                        self?.processor.fireIntent(intent: .PresentError)
                    }
                )
                .disposed(by: disposeBag)
            
        case .PresentBalance:
            break
            
        case .PresentError:
            break
            
        }
    }
}
