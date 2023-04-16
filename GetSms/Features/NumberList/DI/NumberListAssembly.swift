//
//  NumberListAssembly.swift
//  GetSms
//
//  Created by Роман Ломтев on 16.04.2023.
//

enum NumberListAssembly {
    
    static func assemble() -> NumberListViewModel {
        let smsListNetworkWorker = SmsListNetworkWorker()
        let smsListNetworkMapper = SmsListNetworkMapper()
        
        let numberCacheWorker = NumberCacheWorker()
        let numberCacheMapper = NumberCacheMapper()
        
        let interactor = NumberListInteractor(
            smsListNetworkWorker: smsListNetworkWorker,
            smsListNetworkMapper: smsListNetworkMapper,
            numberCacheWorker: numberCacheWorker,
            numberCacheMapper: numberCacheMapper
        )
        let processor = NumberListProcessor(
            interactor: interactor
        )
        
        let formatter = NumberDataListFormatter()
        
        let reducer = NumberListReducer(
            formatter: formatter
        )
        
        let viewModel = NumberListViewModel(
            processor: processor,
            reducer: reducer
        )
        processor.handler = viewModel
        
        return viewModel
    }
}
