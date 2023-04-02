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
}

class ServiceListCacheWorker {
    
    // MARK: - Internal vars
    private let serviceListDataRelay = BehaviorRelay<[Service]>(value: [])
}

extension ServiceListCacheWorker: ServiceListCacheWorkingLogic {
    
    func setServiceList(serviceList: ServiceList) -> Completable {
        serviceListDataRelay.accept(serviceList.services)
        return Completable.empty()
    }
    
    func searchService(searchText: String) -> Single<ServiceList> {
        return Single.just (ServiceList(services: serviceListDataRelay.value.filter { service in
            let serviceNameLowerCased = service.name.lowercased()
            return serviceNameLowerCased.contains(searchText)
            || searchText.contains(serviceNameLowerCased)
            || searchText.isEmpty
        }))
    }
}
