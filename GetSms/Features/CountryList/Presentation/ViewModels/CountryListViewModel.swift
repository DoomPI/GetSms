//
//  CountryListViewModel.swift
//  GetSms
//
//  Created by Роман Ломтев on 01.04.2023.
//

import SwiftUI

protocol CountryListHandlerProtocol: Handler where Intent == CountryListIntent {
}

class CountryListViewModel: ObservableObject {
    
    typealias State = CountryListState
    
    // MARK: - External vars
    @Published private(set) var state: State = .Loading
    
    // MARK: - Internal vars
    private let processor: any CountryListProcessorProtocol
    private let reducer: any CountryListReducerProtocol
    
    // MARK: - Init
    init(
        processor: any CountryListProcessorProtocol,
        reducer: any CountryListReducerProtocol
    ) {
        self.processor = processor
        self.reducer = reducer
    }
    
    func onViewAppear() {
        processor.subscribeToIntents()
    }
    
    func onCountrySelected(countryCode: String) {
        processor.fireIntent(intent: .SelectCountry(countryCode: countryCode))
    }
    
    func loadCountryList() {
        processor.fireIntent(intent: .LoadList)
    }
    
    func blockingLoad() {
        processor.fireIntent(intent: .PresentBlockingLoading)
    }
}

extension CountryListViewModel: CountryListHandlerProtocol {
    
    func handle(intent: CountryListIntent) {
        let newState = self.reducer.reduce(
            currentState: state,
            intent: intent
        )
        self.state = newState
    }
}
