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
    private let interactor: AuthBusinessLogic
    private let disposeBag = DisposeBag()
    private var intentRelay = BehaviorRelay<Intent>(value: .CheckApiKey)
    
    // MARK: - Init
    init(
        interactor: AuthBusinessLogic
    ) {
        self.interactor = interactor
    }
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
                
                switch intent {
                    
                case .SaveApiKey(let apiKey):
                    self.interactor
                        .saveToKeyChain(apiKey: apiKey)
                        .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
                        .observe(on: MainScheduler.instance)
                        .subscribe(
                            onCompleted: {
                                self.fireIntent(intent: .Success)
                            },
                            onError: { error in
                                print(error)
                            }
                        )
                        .disposed(by: self.disposeBag)
                    
                case .CheckApiKey:
                    self.interactor
                        .getApiKey()
                        .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
                        .observe(on: MainScheduler.instance)
                        .subscribe(
                            onSuccess: { _ in
                                self.fireIntent(intent: .Success)
                            },
                            onFailure: { error in
                                self.fireIntent(intent: .ShowAuth)
                            }
                        )
                        .disposed(by: self.disposeBag)
                    
                default:
                    break
                }
                
            }.disposed(by: disposeBag)
    }
    
    private func handleIntent(intent: Intent) {
        handler?.handle(intent: intent)
    }
}


