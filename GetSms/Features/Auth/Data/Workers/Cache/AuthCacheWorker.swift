//
//  AuthCacheWorker.swift
//  GetSms
//
//  Created by Роман Ломтев on 10.04.2023.
//

import Foundation
import RxSwift

protocol AuthCacheWorkingLogic {
    
    func saveToKeyChain(apiKey: ApiKey) -> Completable
    
    func getApiKey() -> Single<ApiKey>
    
}

class AuthCacheWorker {
    
    // MARK: - Internal vars
    private static let keychainHelper = KeychainHelper.shared
}

extension AuthCacheWorker: AuthCacheWorkingLogic {
    
    func saveToKeyChain(apiKey: ApiKey) -> Completable {
        Completable.create { subscriber in
            do {
                try Self.keychainHelper.save(apiKey, service: apiKeyService, account: account)
                subscriber(CompletableEvent.completed)
            } catch {
                subscriber(CompletableEvent.error(error))
            }
            
            return Disposables.create()
        }
    }
    
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
