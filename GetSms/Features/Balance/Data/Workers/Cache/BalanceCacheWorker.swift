//
//  BalanceCacheWorker.swift
//  GetSms
//
//  Created by Роман Ломтев on 10.04.2023.
//

import RxSwift
import RxRelay

protocol BalanceCacheWorkingLogic {
    
    func getApiKey() -> Single<ApiKey>
}

class BalanceCacheWorker {
    
    // MARK: - Internal vars
    private static let keychainHelper = KeychainHelper.shared
}

extension BalanceCacheWorker: BalanceCacheWorkingLogic {
    
    func getApiKey() -> Single<ApiKey> {
        Single<ApiKey>.create { subscriber in
            if let data = Self.keychainHelper.read(
                service: apiKeyService,
                account: account,
                type: ApiKey.self
            ) {
                subscriber(SingleEvent.success(data))
            } else {
                subscriber(SingleEvent.failure(ApiKeyError.NoApiKeyStoredError))
            }
            
            return Disposables.create()
        }
    }
}

enum ApiKeyError: Error {
    
case NoApiKeyStoredError
    
}
