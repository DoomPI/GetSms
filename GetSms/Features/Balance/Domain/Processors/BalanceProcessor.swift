//
//  BalanceProcessor.swift
//  GetSms
//
//  Created by Роман Ломтев on 10.04.2023.
//

import RxRelay
import RxSwift

protocol BalanceProcessorProtocol: Processor where Intent == BalanceIntent {
}

class BalanceProcessor {
    
    typealias Intent = BalanceIntent
    
    // MARK: - External vars
    weak var handler: (any BalanceHandlerProtocol)?
    
    // MARK: - Internal vars
    private let intentRelay = BehaviorRelay<Intent>(value: .Load)
    private let disposeBag = DisposeBag()
}

extension BalanceProcessor: BalanceProcessorProtocol {
    
    func subscribeToIntents() {
        intentRelay
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] event in
                guard
                    let self,
                    let intent = event.element
                else { return }
                
                self.handleIntent(intent: intent)
                
            }.disposed(by: disposeBag)
    }
    
    func fireIntent(intent: Intent) {
        intentRelay.accept(intent)
    }
    
    private func handleIntent(intent: Intent) {
        handler?.handle(intent: intent)
    }
}
