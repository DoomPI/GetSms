//
//  PaymentProcessor.swift
//  GetSms
//
//  Created by Роман Ломтев on 11.04.2023.
//

import RxSwift
import RxRelay

protocol PaymentProcessorProtocol: Processor where Intent == PaymentIntent {
}

class PaymentProcessor {
    
    typealias Intent = PaymentIntent
    
    // MARK: - External vars
    weak var handler: (any PaymentHandlerProtocol)?
    
    // MARK: - Internal vars
    private let disposeBag = DisposeBag()
    private var intentRelay = BehaviorRelay<Intent>(value: .Nothing)
}

extension PaymentProcessor: PaymentProcessorProtocol {
    
    func fireIntent(intent: Intent) {
        self.intentRelay.accept(intent)
    }
    
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
    
    private func handleIntent(intent: Intent) {
        handler?.handle(intent: intent)
    }
}




