//
//  KeychainWorker.swift
//  GetSms
//
//  Created by Роман Ломтев on 15.04.2023.
//

import RxSwift

class KeychainWorker {
    
    // MARK: - External vars
    static let shared = KeychainWorker()
    
    // MARK: - Internal vars
    private static let keychainHelper = KeychainHelper.shared
    
    // MARL: - Init
    private init() {
    }
    
    func setApiKey(apiKey: ApiKey) -> Completable {
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
    
    func deleteApiKey() -> Completable {
        Completable.create { subscriber in
            Self.keychainHelper.delete(service: apiKeyService, account: account)
            subscriber(CompletableEvent.completed)
            
            return Disposables.create()
        }
    }
}
