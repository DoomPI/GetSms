//
//  ServiceListCacheWorker.swift
//  GetSms
//
//  Created by Роман Ломтев on 01.04.2023.
//

import RxRelay
import RxSwift

protocol ServiceListCacheWorkingLogic {
    
    func setServiceList(serviceList: ServiceList) -> Completable
    
    func searchService(searchText: String) -> Single<ServiceList>
    
    func getCountryCode() -> Single<String>
}

class ServiceListCacheWorker {
    
    // MARK: - Internal vars
    private static let defaultCountryCode = "ru"
    private let serviceListDataRelay = BehaviorRelay<ServiceList>(value: ServiceList(
        services: [],
        countryCode: defaultCountryCode
    ))
}

extension ServiceListCacheWorker: ServiceListCacheWorkingLogic {
    
    func setServiceList(serviceList: ServiceList) -> Completable {
        serviceListDataRelay.accept(serviceList)
        return Completable.empty()
    }
    
    func searchService(searchText: String) -> Single<ServiceList> {
        let value = serviceListDataRelay.value
        return Single.just (ServiceList(
            services: value.services.filter { service in
                let serviceNameLowerCased = service.name.lowercased()
                return serviceNameLowerCased.contains(searchText)
                || searchText.contains(serviceNameLowerCased)
                || searchText.isEmpty
            },
            countryCode: value.countryCode
        ))
    }
    
    func getCountryCode() -> Single<String> {
        return Single.just(serviceListDataRelay.value.countryCode)
    }
}
