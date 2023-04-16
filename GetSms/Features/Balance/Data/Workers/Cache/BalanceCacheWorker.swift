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
    private static let keychainWorker = KeychainWorker.shared
}

extension BalanceCacheWorker: BalanceCacheWorkingLogic {
    
    func getApiKey() -> Single<ApiKey> {
        return Self.keychainWorker.getApiKey()
    }
}

enum ApiKeyError: Error {
    
case NoApiKeyStoredError
    
}
