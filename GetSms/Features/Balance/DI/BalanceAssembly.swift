//
//  BalanceAssembly.swift
//  GetSms
//
//  Created by Роман Ломтев on 10.04.2023.
//

enum BalanceAssembly {
    
    static func assemble() -> BalanceViewModel {
        let networkWorker = BalanceNetworkWorker()
        let networkMapper = BalanceNetworkMapper()
        let cacheWorker = BalanceCacheWorker()
        let interactor = BalanceInteractor(
            networkWorker: networkWorker,
            networkMapper: networkMapper,
            cacheWorker: cacheWorker
        )
        
        let processor = BalanceProcessor(
            interactor: interactor
        )
        
        let formatter = BalanceFormatter()
        let reducer = BalanceReducer(formatter: formatter)
        let viewModel = BalanceViewModel(
            processor: processor,
            reducer: reducer
        )
        processor.handler = viewModel
        
        return viewModel
    }
}
