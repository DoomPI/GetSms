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
    
    func purchaseNumber(serviceCode: String) -> Completable
}

class ServiceListInteractor {
    
    // MARK: - Internal vars
    private let numberNetworkWorker: NumberNetworkWorkingLogic
    private let numberNetworkMapper: NumberNetworkMapper
    
    private let serviceListNetworkWorker: ServiceListNetworkWorkingLogic
    private let serviceListNetworkMapper: ServiceListNetworkMapper
    
    private let serviceListCacheWorker: ServiceListCacheWorkingLogic
    
    private let numberCacheWorker: NumberCacheWorkingLogic
    private let numberCacheMapper: NumberCacheMapper
    
    private static let keychainWorker = KeychainWorker.shared
    
    private static let defaultCountryCode = "ru"
    
    // MARK: - Init
    init(
        numberNetworkWorker: NumberNetworkWorkingLogic,
        numberNetworkMapper: NumberNetworkMapper,
        serivceListNetworkWorker: ServiceListNetworkWorkingLogic,
        serviceListNetworkMapper: ServiceListNetworkMapper,
        serviceListCacheWorker: ServiceListCacheWorkingLogic,
        numberCacheWorker: NumberCacheWorkingLogic,
        numberCacheMapper: NumberCacheMapper
    ) {
        self.numberNetworkWorker = numberNetworkWorker
        self.numberNetworkMapper = numberNetworkMapper
        self.serviceListNetworkWorker = serivceListNetworkWorker
        self.serviceListNetworkMapper = serviceListNetworkMapper
        self.serviceListCacheWorker = serviceListCacheWorker
        self.numberCacheWorker = numberCacheWorker
        self.numberCacheMapper = numberCacheMapper
    }
}

extension ServiceListInteractor: ServiceListBusinessLogic {
   
    func getServiceList(countryCode: String?) -> Single<ServiceList> {
        if let countryCode {
            return getServiceListFromNetwork(countryCode: countryCode).flatMap { serviceList in
                self.setServiceListInCache(serviceList: serviceList)
                    .andThen(Single.just(serviceList))
            }
        }
        
        return getCountryCodeFromCache().flatMap { countryCode in
            self.getServiceListFromNetwork(countryCode: countryCode).flatMap { serviceList in
                self.setServiceListInCache(serviceList: serviceList)
                    .andThen(Single.just(serviceList))
            }
        }
    }
    
    func searchService(searchText: String) -> Single<ServiceList> {
        return serviceListCacheWorker.searchService(searchText: searchText)
    }
    
    func purchaseNumber(serviceCode: String) -> Completable {
        return Single.zip(
            getApiKey(),
            getCountryCodeFromCache()
        ) { (apiKey: ApiKey, countryCode: String) in
            return (apiKey, countryCode)
        }
        .flatMapCompletable { (apiKey, countryCode) in
            return self.getNumberFromNetwork(
                apiKey: apiKey,
                serviceCode: serviceCode,
                countryCode: countryCode
            )
            .flatMapCompletable { number in
                self.appendNumbers(newNumber: number)
            }
        }
    }
    
    private func getServiceListFromNetwork(countryCode: String) -> Single<ServiceList> {
        return serviceListNetworkWorker.getServiceList(countryCode: countryCode).map { dto in
            self.serviceListNetworkMapper.fromDto(
                dto: dto,
                countryCode: countryCode
            )
        }
    }
    
    private func setServiceListInCache(serviceList: ServiceList) -> Completable {
        return serviceListCacheWorker.setServiceList(serviceList: serviceList)
    }
    
    private func getCountryCodeFromCache() -> Single<String> {
        return serviceListCacheWorker.getCountryCode()
    }
    
    private func getApiKey() -> Single<ApiKey> {
        return Self.keychainWorker.getApiKey()
    }
    
    private func getNumberFromNetwork(
        apiKey: ApiKey,
        serviceCode: String,
        countryCode: String
    ) -> Single<Number> {
        return numberNetworkWorker.getNumber(
            apiKey: apiKey.apiKey,
            serviceCode: serviceCode,
            countryCode: countryCode
        ).map { dto in
            self.numberNetworkMapper.fromDto(dto: dto)
        }
    }
    
    private func getNumbersFromCache() -> Single<[Number]> {
        return numberCacheWorker.getNumbers().map { dto in
            self.numberCacheMapper.fromDto(dto: dto)
        }
    }
    
    private func setNumbersInCache(numbers: [Number]) -> Completable {
        Completable.deferred {
            let dto = self.numberCacheMapper.toDto(model: numbers)
            return self.numberCacheWorker.setNumbers(numbers: dto)
        }
    }
    
    private func appendNumbers(newNumber: Number) -> Completable {
        self.getNumbersFromCache().flatMapCompletable { numbers in
            var newNumbers = numbers
            newNumbers.append(newNumber)
            return self.setNumbersInCache(numbers: newNumbers)
        }
    }
}
