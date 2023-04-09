//
//  WebProcessor.swift
//  GetSms
//
//  Created by Роман Ломтев on 08.04.2023.
//

import RxRelay
import RxSwift

protocol WebProcessorProtocol: Processor where Intent == WebIntent {
}

class WebProcessor {
    
    typealias Intent = WebIntent
    
    // MARK: - External vars
    weak var handler: (any WebHandlerProtocol)?
    
    // MARK: - Internal vars
    private var intentRelay = BehaviorRelay<Intent>(value: .Reload)
    private let disposeBag = DisposeBag()
}

extension WebProcessor: WebProcessorProtocol {
    
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
