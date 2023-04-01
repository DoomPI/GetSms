//
//  ServiceListInteractor.swift
//  GetSms
//
//  Created by Роман Ломтев on 26.03.2023.
//

import RxSwift

protocol ServiceListBusinessLogic {
    
    func getServiceList() -> Single<ServiceList>
    
    func searchService(searchText: String) -> Single<ServiceList>
}

class ServiceListInteractor {
    
    // MARK: - Internal vars
    private let cacheWorker: ServiceListCacheWorkingLogic
    
    private let networkWorker: ServiceListNetworkWorkingLogic
    private let networkMapper: ServiceListNetworkMapper
    
    // MARK: - Init
    init(
        cacheWorker: ServiceListCacheWorkingLogic,
        networkWorker: ServiceListNetworkWorkingLogic,
        networkMapper: ServiceListNetworkMapper
    ) {
        self.cacheWorker = cacheWorker
        self.networkWorker = networkWorker
        self.networkMapper = networkMapper
    }
}

extension ServiceListInteractor: ServiceListBusinessLogic {
    
    func getServiceList() -> Single<ServiceList> {
        return getServiceListFromNetwork().flatMap { serviceList in
            self.setServiceListInCache(serviceList: serviceList)
                .andThen(Single.just(serviceList))
        }
    }
    
    func searchService(searchText: String) -> Single<ServiceList> {
        return cacheWorker.searchService(searchText: searchText)
    }
    
    private func getServiceListFromNetwork() -> Single<ServiceList> {
        return networkWorker.getServiceList().map { dto in
            self.networkMapper.fromDto(dto: dto)
        }
    }
    
    private func setServiceListInCache(serviceList: ServiceList) -> Completable {
        return cacheWorker.setServiceList(serviceList: serviceList)
    }
}
