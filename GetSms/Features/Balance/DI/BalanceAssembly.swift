//
//  BalanceAssembly.swift
//  GetSms
//
//  Created by Роман Ломтев on 10.04.2023.
//

enum BalanceAssembly {
    
    static func assemble() -> BalanceViewModel {
        let processor = BalanceProcessor()
        
        let formatter = BalanceFormatter()
        let reducer = BalanceReducer(formatter: formatter)
        
        let networkWorker = BalanceNetworkWorker()
        let networkMapper = BalanceNetworkMapper()
        let cacheWorker = BalanceCacheWorker()
        let interacor = BalanceInteractor(
            networkWorker: networkWorker,
            networkMapper: networkMapper,
            cacheWorker: cacheWorker
        )
        
        let viewModel = BalanceViewModel(
            processor: processor,
            reducer: reducer,
            interactor: interacor
        )
        processor.handler = viewModel
        
        return viewModel
    }
}
