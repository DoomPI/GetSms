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
    
    func deleteApiKey() -> Completable
}

class BalanceCacheWorker {
    
    // MARK: - Internal vars
    private static let keychainWorker = KeychainWorker.shared
}

extension BalanceCacheWorker: BalanceCacheWorkingLogic {
    
    func getApiKey() -> Single<ApiKey> {
        return Self.keychainWorker.getApiKey()
    }
    
    func deleteApiKey() -> Completable {
        return Self.keychainWorker.deleteApiKey()
    }
}

enum ApiKeyError: Error {
    
case NoApiKeyStoredError
    
}
