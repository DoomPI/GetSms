//
//  BalanceInteractor.swift
//  GetSms
//
//  Created by Роман Ломтев on 10.04.2023.
//

import RxSwift

protocol BalanceBusinessLogic {
    
    func getBalance() -> Single<Balance>
}

class BalanceInteractor {
    
    // MARK: - Internal vars
    private let networkWorker: BalanceNetworkWorkingLogic
    private let networkMapper: BalanceNetworkMapper
    
    private let cacheWorker: BalanceCacheWorkingLogic
    
    
    // MARK: - Init
    init(
        networkWorker: BalanceNetworkWorkingLogic,
        networkMapper: BalanceNetworkMapper,
        cacheWorker: BalanceCacheWorkingLogic
    ) {
        self.networkWorker = networkWorker
        self.networkMapper = networkMapper
        self.cacheWorker = cacheWorker
    }
}

extension BalanceInteractor: BalanceBusinessLogic {
    
    func getBalance() -> Single<Balance> {
        return getApiKey().flatMap { apiKey in
            self.networkWorker.getBalance(apiKey: apiKey.apiKey).map { dto in
                self.networkMapper.fromDto(dto: dto)
            }
        }
    }
    
    private func getApiKey() -> Single<ApiKey> {
        return cacheWorker.getApiKey()
    }
}
