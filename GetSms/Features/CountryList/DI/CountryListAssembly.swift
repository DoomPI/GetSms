//
//  CountryListAssembly.swift
//  GetSms
//
//  Created by Роман Ломтев on 01.04.2023.
//

enum CountryListAssembly {
    
    static func assemble() -> CountryListViewModel {
        let networkWorker = CountryListNetworkWorker()
        let networkMapper = CountryListNetworkMapper()
        let interactor = CountryListInteractor(
            networkWorker: networkWorker,
            networkMapper: networkMapper
        )
        
        let processor = CountryListProcessor(
            interactor: interactor
        )
        
        let formatter = CountryListFormatter()
        let errorFormatter = CountryListErrorFormatter()
        let reducer = CountryListReducer(
            formatter: formatter,
            errorFormatter: errorFormatter
        )
        
        let viewModel = CountryListViewModel(
            processor: processor,
            reducer: reducer
        )
        processor.handler = viewModel
        
        return viewModel
    }
}
