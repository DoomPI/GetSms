//
//  AuthProcessor.swift
//  GetSms
//
//  Created by Роман Ломтев on 09.04.2023.
//

import RxSwift
import RxRelay

protocol AuthProcessorProtocol: Processor where Intent == AuthIntent {
}

class AuthProcessor {
    
    typealias Intent = AuthIntent
    
    // MARK: - External vars
    weak var handler: (any AuthHandlerProtocol)?
    
    // MARK: - Internal vars
    private let disposeBag = DisposeBag()
    private var intentRelay = BehaviorRelay<Intent>(value: .None)
}

extension AuthProcessor: AuthProcessorProtocol {
    
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


