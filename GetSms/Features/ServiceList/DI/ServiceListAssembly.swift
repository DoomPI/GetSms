//
//  ServiceListAssembly.swift
//  GetSms
//
//  Created by Роман Ломтев on 26.03.2023.
//

import Foundation

enum ServiceListAssembly {
    
    static func assemble() -> ServiceListViewModel {
        let cacheWorker = ServiceListCacheWorker()
        
        let networkWorker = ServiceListNetworkWorker()
        let networkMapper = ServiceListNetworkMapper()
        
        let interactor = ServiceListInteractor(
            cacheWorker: cacheWorker,
            networkWorker: networkWorker,
            networkMapper: networkMapper
        )
        
        let formatter = ServiceListFormatter()
        let errorFormatter = ServiceListErrorFormatter()
        
        let reducer = ServiceListReducer(
            formatter: formatter,
            errorFormatter: errorFormatter
        )
        let processor = ServiceListProcessor(
            interactor: interactor
        )
        let viewModel = ServiceListViewModel(
            processor: processor,
            reducer: reducer
        )
        processor.handler = viewModel
        
        return viewModel
    }
}
