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
    private let interactor: BalanceBusinessLogic
    private let intentRelay = BehaviorRelay<Intent>(value: .Load)
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    init(
        interactor: BalanceBusinessLogic
    ) {
        self.interactor = interactor
    }
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
                
                switch intent {
                    
                case .Load:
                    self.interactor
                        .getBalance()
                        .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
                        .observe(on: MainScheduler.instance)
                        .subscribe(
                            onSuccess: { [weak self] balance in
                                self?.fireIntent(intent: .PresentBalance(model: balance))
                            },
                            onFailure: { [weak self] _ in
                                self?.fireIntent(intent: .PresentError)
                            }
                        )
                        .disposed(by: self.disposeBag)
                    
                default:
                    break
                    
                }
                
            }.disposed(by: disposeBag)
    }
    
    func fireIntent(intent: Intent) {
        intentRelay.accept(intent)
    }
    
    private func handleIntent(intent: Intent) {
        handler?.handle(intent: intent)
    }
}
