//
//  ServiceListViewModel.swift
//  GetSms
//
//  Created by Роман Ломтев on 25.03.2023.
//

import SwiftUI
import RxSwift

protocol ServiceListHandlerProtocol: Handler where Intent == ServiceListIntent {
}

class ServiceListViewModel: ObservableObject {
    
    typealias State = ServiceListState
    typealias Intent = ServiceListIntent
    
    // MARK: - External vars
    @Published private(set) var state: State
    
    // MARK: - Internal vars
    private let processor: any ServiceListProcessorProtocol
    private let reducer: any ServiceListReducerProtocol
    private let interactor: ServiceListBusinessLogic
    private let disposeBag = DisposeBag()
    
    init(
        state: State,
        processor: any ServiceListProcessorProtocol,
        reducer: any ServiceListReducerProtocol,
        interactor: ServiceListBusinessLogic
    ) {
        self.state = state
        self.processor = processor
        self.reducer = reducer
        self.interactor = interactor
    }
    
    func onViewAppear() {
        processor.subscribeToIntents()
    }
    
    func loadServiceList() {
        processor.fireIntent(intent: .LoadList)
    }
}

extension ServiceListViewModel: ServiceListHandlerProtocol {
    
    func handle(intent: Intent) {
        let newState = self.reducer.reduce(intent: intent)
        self.state = newState
        
        switch intent {
        case .LoadList:
            interactor
                .getServiceList()
                .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
                .observe(on: MainScheduler.instance)
                .subscribe(
                    onSuccess: { [weak self] serviceList in
                        guard let self else { return }
                        self.processor.fireIntent(intent: .PresentList(model: serviceList))
                    },
                    onFailure: { [weak self] error in
                        guard let self else { return }
                        self.processor.fireIntent(intent: .PresentError(error: error))
                    }
                )
                .disposed(by: disposeBag)
        case .PresentList:
            break
        case .PresentError:
            break
        }
    }
}

