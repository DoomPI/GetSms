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
    
}

class AuthCacheWorker {
    
    private let keychainHelper = KeychainHelper.shared
}

extension AuthCacheWorker: AuthCacheWorkingLogic {
    
    func saveToKeyChain(apiKey: ApiKey) -> Completable {
        Completable.create { [weak self] subscriber in
            do {
                try self?.keychainHelper.save(apiKey, service: apiKeyService, account: account)
                subscriber(CompletableEvent.completed)
            } catch {
                subscriber(CompletableEvent.error(error))
            }
            
            return Disposables.create()
        }
    }
}
