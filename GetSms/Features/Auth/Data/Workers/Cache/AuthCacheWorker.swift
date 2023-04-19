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
    
    // Internal vars
    private static let keychainWorker = KeychainWorker.shared
}

extension AuthCacheWorker: AuthCacheWorkingLogic {
    
    func saveToKeyChain(apiKey: ApiKey) -> Completable {
        return Self.keychainWorker.setApiKey(apiKey: apiKey)
    }
    
    func getApiKey() -> Single<ApiKey> {
        return Self.keychainWorker.getApiKey()
    }
}
