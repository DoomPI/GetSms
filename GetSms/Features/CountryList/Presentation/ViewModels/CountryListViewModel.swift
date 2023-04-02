//
//  CountryListViewModel.swift
//  GetSms
//
//  Created by Роман Ломтев on 01.04.2023.
//

import RxSwift
import SwiftUI

protocol CountryListHandlerProtocol: Handler where Intent == CountryListIntent {
}

class CountryListViewModel: ObservableObject {
    
    typealias State = CountryListState
    
    // MARK: - External vars
    @Published private(set) var state: State = .Idle
    
    // MARK: - Internal vars
    private let processor: any CountryListProcessorProtocol
    private let reducer: any CountryListReducerProtocol
    private let interactor: CountryListBusinessLogic
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    init(
        processor: any CountryListProcessorProtocol,
        reducer: any CountryListReducerProtocol,
        interactor: CountryListBusinessLogic
    ) {
        self.processor = processor
        self.reducer = reducer
        self.interactor = interactor
    }
    
    func onViewAppear() {
        processor.subscribeToIntents()
    }
    
    func loadCountryList() {
        processor.fireIntent(intent: .LoadList)
    }
}

extension CountryListViewModel: CountryListHandlerProtocol {
    
    func handle(intent: CountryListIntent) {
        let newState = self.reducer.reduce(intent: intent)
        self.state = newState
        
        switch intent {
            
        case .LoadList:
            interactor
                .getCountryList()
                .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
                .observe(on: MainScheduler.instance)
                .subscribe(
                    onSuccess: { [weak self] countryList in
                        self?.processor.fireIntent(intent: .PresentList(model: countryList))
                    },
                    onFailure: { [weak self] error in
                        self?.processor.fireIntent(intent: .PresentError(error: error))
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
