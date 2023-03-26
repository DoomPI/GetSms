//
//  ServiceListAssembly.swift
//  GetSms
//
//  Created by Роман Ломтев on 26.03.2023.
//

import Foundation

enum ServiceListAssembly {
    
    static func assemble() -> ServiceListViewModel {
        let networkWorker = ServiceListNetworkWorker()
        let networkMapper = ServiceListNetworkMapper()
        let interactor = ServiceListInteractor(
            networkWorker: networkWorker,
            networkMapper: networkMapper
        )
        let formatter = ServiceListFormatter()
        let errorFormatter = ServiceListErrorFormatter()
        
        return ServiceListViewModel(
            interactor: interactor,
            formatter: formatter,
            errorFormatter: errorFormatter
        )
    }
}
