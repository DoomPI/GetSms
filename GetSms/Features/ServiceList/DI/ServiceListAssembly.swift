//
//  ServiceListAssembly.swift
//  GetSms
//
//  Created by Роман Ломтев on 26.03.2023.
//

import Foundation

enum ServiceListAssembly {
    
    static func assemble() -> ServiceListViewModel {
        let numberNetworkWorker = NumberNetworkWorker()
        let numberNetworkMapper = NumberNetworkMapper()
        
        let serviceListNetworkWorker = ServiceListNetworkWorker()
        let serviceListNetworkMapper = ServiceListNetworkMapper()
        
        let serviceListCacheWorker = ServiceListCacheWorker()
        let numberCacheWorker = NumberCacheWorker()
        let numberCacheMapper = NumberCacheMapper()
        
        let interactor = ServiceListInteractor(
            numberNetworkWorker: numberNetworkWorker,
            numberNetworkMapper: numberNetworkMapper,
            serivceListNetworkWorker: serviceListNetworkWorker,
            serviceListNetworkMapper: serviceListNetworkMapper,
            serviceListCacheWorker: serviceListCacheWorker,
            numberCacheWorker: numberCacheWorker,
            numberCacheMapper: numberCacheMapper
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
