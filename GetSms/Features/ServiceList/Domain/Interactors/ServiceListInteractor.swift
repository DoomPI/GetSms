//
//  ServiceListInteractor.swift
//  GetSms
//
//  Created by Роман Ломтев on 26.03.2023.
//

import RxSwift

protocol ServiceListBusinessLogic {
    
    func getServiceList() -> Single<ServiceList>
}

class ServiceListInteractor {
    
    // MARK: - Internal vars
    private let networkWorker: ServiceListNetworkWorkingLogic
    private let networkMapper: ServiceListNetworkMapper
    
    // MARK: - Init
    init(
        networkWorker: ServiceListNetworkWorkingLogic,
        networkMapper: ServiceListNetworkMapper
    ) {
        self.networkWorker = networkWorker
        self.networkMapper = networkMapper
    }
}

extension ServiceListInteractor: ServiceListBusinessLogic {
    
    func getServiceList() -> Single<ServiceList> {
        return getServiceListFromNetwork()
    }
    
    private func getServiceListFromNetwork() -> Single<ServiceList> {
        return networkWorker.getServiceList().map { dto in
            self.networkMapper.fromDto(dto: dto)
        }
    }
}
