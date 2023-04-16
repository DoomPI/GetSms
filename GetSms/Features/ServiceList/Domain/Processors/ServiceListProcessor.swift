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

class ServiceListProcessor {
    
    typealias Intent = ServiceListIntent
    
    // MARK: - External vars
    weak var handler: (any ServiceListHandlerProtocol)?
    
    // MARK: - Internal vars
    private let interactor: ServiceListBusinessLogic
    private let disposeBag = DisposeBag()
    private var intentRelay = BehaviorRelay<Intent>(value: .Nothing)
    
    // MARK: - Init
    init(
        interactor: ServiceListBusinessLogic
    ) {
        self.interactor = interactor
    }
}

extension ServiceListProcessor: ServiceListProcessorProtocol {
    
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
                    
                case .LoadList(let countryCode):
                    self.interactor
                        .getServiceList(countryCode: countryCode)
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
                    
                case .SearchService(let searchText):
                    self.interactor
                        .searchService(searchText: searchText)
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
                    
                case .PurchaseNumber(let serviceCode):
                    self.interactor
                        .purchaseNumber(serviceCode: serviceCode)
                        .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
                        .observe(on: MainScheduler.instance)
                        .subscribe()
                        .disposed(by: self.disposeBag)
                    
                case .Nothing, .PresentList, .PresentError:
                    break
                }
                
            }.disposed(by: disposeBag)
    }
    
    private func handleIntent(intent: Intent) {
        handler?.handle(intent: intent)
    }
}
