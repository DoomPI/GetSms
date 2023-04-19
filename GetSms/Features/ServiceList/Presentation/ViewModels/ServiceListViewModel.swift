//
//  ServiceListViewModel.swift
//  GetSms
//
//  Created by Роман Ломтев on 25.03.2023.
//

import SwiftUI

protocol ServiceListHandlerProtocol: Handler where Intent == ServiceListIntent {
}

class ServiceListViewModel: ObservableObject {
    
    typealias State = ServiceListState
    typealias RouteState = ServiceListRouteState
    
    // MARK: - External vars
    @Published private(set) var state: State = .Idle
    
    @Published private(set) var routeState: RouteState = .Idle
    
    // MARK: - Internal vars
    private let processor: any ServiceListProcessorProtocol
    private let reducer: any ServiceListReducerProtocol
    
    init(
        processor: any ServiceListProcessorProtocol,
        reducer: any ServiceListReducerProtocol
    ) {
        self.processor = processor
        self.reducer = reducer
    }
    
    func onViewAppear() {
        processor.subscribeToIntents()
    }
    
    func loadServiceList(countryCode: String? = nil) {
        processor.fireIntent(intent: .LoadList(countryCode: countryCode))
    }
    
    func searchService(inputText: String) {
        let searchText = inputText.trimmingCharacters(in: .whitespaces).lowercased()
        processor.fireIntent(intent: .SearchService(searchText: searchText))
    }
    
    func purchaseNumber(serviceCode: String, serviceName: String) {
        processor.fireIntent(intent: .PurchaseNumber(
            serviceCode: serviceCode,
            serviceName: serviceName
        ))
    }
}

extension ServiceListViewModel: ServiceListHandlerProtocol {
    
    func handle(intent: Intent) {
        let newState = self.reducer.reduce(
            currentState: state,
            intent: intent
        )
        self.state = newState
        
        switch intent {
            
        case .NumberListInitRoute:
            self.routeState = .NumberListInitRouting
            
        case .NumberListFinishRoute:
            self.routeState = .NumberListFinishRouting
            
        default:
            self.routeState = .Idle
            
        }
    }
}

