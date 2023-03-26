//
//  ServiceListViewModel.swift
//  GetSms
//
//  Created by Роман Ломтев on 25.03.2023.
//

import SwiftUI
import RxSwift
import RxRelay

class ServiceListViewModel: ObservableObject {
    
    typealias State = ServiceListState
    typealias Intent = ServiceListIntent
    
    // MARK: - External vars
    @Published var state: ServiceListState = .Idle
    
    // MARK: - Internal vars
    private let interactor: ServiceListBusinessLogic
    private let formatter: ServiceListFormatter
    private let errorFormatter: ServiceListErrorFormatter
    
    private let reducer: ServiceListReducer = ServiceListReducer()
    private let disposeBag = DisposeBag()
    private var intentRelay = BehaviorRelay<ServiceListIntent>(value: .LoadList)
    
    init(
        interactor: ServiceListBusinessLogic,
        formatter: ServiceListFormatter,
        errorFormatter: ServiceListErrorFormatter
    ) {
        self.interactor = interactor
        self.formatter = formatter
        self.errorFormatter = errorFormatter
    }
    
    private class ServiceListReducer: Reducer {
        
        func reduce(intent: Intent) -> State {
            switch intent {
                
            case .LoadList:
                return .Loading
                
            case .ShowList(let vo):
                return .Loaded(vo: vo)
                
            case .ShowError(let vo):
                return .Error(vo: vo)
            }
        }
    }
}

extension ServiceListViewModel: Processor {
    
    func subscribeToIntents() {
        intentRelay.subscribe { [weak self] event in
            guard
                let self,
                let intent = event.element
            else { return }
            
            let newState = self.reducer.reduce(intent: intent)
            self.state = newState
            
            self.handleIntent(intent: intent) { [weak self] newIntent in
                self?.intentRelay.accept(newIntent)
            }

        }.disposed(by: disposeBag)
    }
    
    func handleIntent(intent: Intent, completion: @escaping (Intent) -> Void) {
        
        switch intent {
            
        case .LoadList:
            interactor
                .getServiceList()
                .observe(on: MainScheduler.instance)
                .subscribe(
                    onSuccess: { serviceList in
                        completion(.ShowList(vo: self.formatter.format(model: serviceList)))
                    },
                    onFailure: { error in
                        completion(.ShowError(vo: self.errorFormatter.format()))
                    }
                )
                .disposed(by: disposeBag)
            
        case .ShowList:
            break
            
        case .ShowError:
            break
        }
    }
}

