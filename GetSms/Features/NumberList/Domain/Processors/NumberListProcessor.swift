//
//  NumberListProcessor.swift
//  GetSms
//
//  Created by Роман Ломтев on 16.04.2023.
//

import RxSwift
import RxRelay

protocol NumberListProcessorProtocol: Processor where Intent == NumberListIntent {
}

class NumberListProcessor {
    
    typealias Intent = NumberListIntent
    
    // MARK: - External vars
    weak var handler: (any NumberListHandlerProtocol)?
    
    // MARK: - Internal vars
    private let interactor: NumberListBusinessLogic
    private let disposeBag = DisposeBag()
    private var intentRelay = BehaviorRelay<Intent>(value: .LoadList())
    
    // MARK: - Init
    init(
        interactor: NumberListBusinessLogic
    ) {
        self.interactor = interactor
    }
}

extension NumberListProcessor: NumberListProcessorProtocol {
    
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
                    
                case .LoadList(let numbersDisplayedCount):
                    self.fireIntent(intent: .PresentLoading(numbersDisplayedCount: numbersDisplayedCount))
                    self.interactor
                        .getNumberList()
                        .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
                        .observe(on: MainScheduler.instance)
                        .subscribe(
                            onSuccess: { [weak self] serviceList in
                                self?.fireIntent(intent: .PresentList(model: serviceList))
                            },
                            onFailure: { [weak self] error in
                                self?.fireIntent(intent: .PresentError(error: error))
                            }
                        )
                        .disposed(by: self.disposeBag)
                    
                case .CancelNumber(let numberId):
                    self.interactor
                        .setStatus(numberSetStatus: NumberSetStatus(
                            numberId: numberId,
                            status: .End
                        ))
                        .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
                        .observe(on: MainScheduler.instance)
                        .subscribe(
                            onSuccess: { [weak self] numberGetStatus in
                                self?.fireIntent(intent: .LoadList())
                            },
                            onFailure: { [weak self] error in
                                self?.fireIntent(intent: .PresentError(error: error))
                            }
                        )
                        .disposed(by: self.disposeBag)
                    
                case .ContinueNumber(let numberId):
                    self.interactor
                        .setStatus(numberSetStatus: NumberSetStatus(
                            numberId: numberId,
                            status: .Send
                        ))
                        .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
                        .observe(on: MainScheduler.instance)
                        .subscribe(
                            onSuccess: { [weak self] numberGetStatus in
                                self?.fireIntent(intent: .LoadList())
                            },
                            onFailure: { [weak self] error in
                                self?.fireIntent(intent: .PresentError(error: error))
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

