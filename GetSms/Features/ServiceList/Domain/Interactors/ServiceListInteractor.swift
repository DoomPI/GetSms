//
//  ServiceListInteractor.swift
//  GetSms
//
//  Created by Роман Ломтев on 26.03.2023.
//

import RxSwift

protocol ServiceListBusinessLogic {
    
    func getServiceList(countryCode: String?) -> Single<ServiceList>
    
    func searchService(searchText: String) -> Single<ServiceList>
}

class ServiceListInteractor {
    
    // MARK: - Internal vars
    private let cacheWorker: ServiceListCacheWorkingLogic
    
    private let networkWorker: ServiceListNetworkWorkingLogic
    private let networkMapper: ServiceListNetworkMapper
    
    private static let defaultCountryCode = "ru"
    
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
    
    func getServiceList(countryCode: String?) -> Single<ServiceList> {
        return getServiceListFromNetwork(countryCode: countryCode).flatMap { serviceList in
            self.setServiceListInCache(serviceList: serviceList)
                .andThen(Single.just(serviceList))
        }
    }
    
    func searchService(searchText: String) -> Single<ServiceList> {
        return cacheWorker.searchService(searchText: searchText)
    }
    
    private func getServiceListFromNetwork(countryCode: String?) -> Single<ServiceList> {
        let code = countryCode ?? Self.defaultCountryCode
        return networkWorker.getServiceList(countryCode: code).map { dto in
            self.networkMapper.fromDto(
                dto: dto,
                countryCode: code
            )
        }
    }
    
    private func setServiceListInCache(serviceList: ServiceList) -> Completable {
        return cacheWorker.setServiceList(serviceList: serviceList)
    }
}
