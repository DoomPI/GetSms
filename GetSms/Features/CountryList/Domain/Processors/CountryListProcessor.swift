//
//  CountryListProcessor.swift
//  GetSms
//
//  Created by Роман Ломтев on 01.04.2023.
//

import RxSwift
import RxRelay

protocol CountryListProcessorProtocol: Processor where Intent == CountryListIntent {
}

class CountryListProcessor {
    
    typealias Intent = CountryListIntent
    
    // MARK: - External vars
    weak var handler: (any CountryListHandlerProtocol)?
    
    // MARK: - Internal vars
    private let disposeBag = DisposeBag()
    private var intentRelay = BehaviorRelay<Intent>(value: .LoadList)
}

extension CountryListProcessor: CountryListProcessorProtocol {
    
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

