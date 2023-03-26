//
//  ServiceListProcessor.swift
//  GetSms
//
//  Created by Роман Ломтев on 26.03.2023.
//

import RxSwift
import RxRelay

protocol ServiceListProcessorProtocol: Processor where Intent == ServiceListIntent {
}

class ServiceListProcessor: ServiceListProcessorProtocol {
    
    typealias Intent = ServiceListIntent
    typealias State = ServiceListState
    
    weak var handler: (any ServiceListHandlerProtocol)?
    
    // MARK: - Internal vars
    private let disposeBag = DisposeBag()
    private var intentRelay = BehaviorRelay<Intent>(value: .LoadList)
    
    func fireIntent(intent: Intent) {
        self.intentRelay.accept(intent)
    }
    
    func subscribeToIntents() {
        intentRelay.subscribe { [weak self] event in
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
