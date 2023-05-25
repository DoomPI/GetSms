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
    
    func purchaseNumber(serviceCode: String, serviceName: String) -> Completable
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
    
    func purchaseNumber(serviceCode: String, serviceName: String) -> Completable {
        return Single.zip(
            getApiKey(),
            getCountryCodeFromCache()
        )
        .flatMap { (apiKey, countryCode) in
            self.getNumberFromNetwork(
                apiKey: apiKey,
                serviceCode: serviceCode,
                serviceName: serviceName,
                countryCode: countryCode
            )
        }
        .flatMapCompletable { result in
            switch result {
            case .success(let number):
                return self.appendNumbers(newNumber: number)
            case .failure(let error):
                return Completable.error(error)
            }
        }
    }
    
    private func getServiceListFromNetwork(countryCode: String) -> Single<ServiceList> {
        return serviceListNetworkWorker.getServiceList(countryCode: countryCode).map { dto in
            try self.serviceListNetworkMapper.fromDto(
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
        serviceName: String,
        countryCode: String
    ) -> Single<Result<Number, PurchaseNumberError>> {
        return numberNetworkWorker.getNumber(
            apiKey: apiKey.apiKey,
            serviceCode: serviceCode,
            countryCode: countryCode
        ).map { result in
            switch result {
            case .success(let dto):
                print(dto)
                return .success( try self.numberNetworkMapper.fromDto(serviceName: serviceName, dto: dto))
            case .failure(let error):
                return .failure(error)
            }
            
        }
    }
    
    private func getNumbersFromCache() -> Single<[Number]> {
        return numberCacheWorker.getNumbers().map { dto in
            try self.numberCacheMapper.fromDto(dto: dto)
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
