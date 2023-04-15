//
//  AuthInteractor.swift
//  GetSms
//
//  Created by Роман Ломтев on 10.04.2023.
//

import RxSwift

protocol AuthBusinessLogic {
    
    func saveToKeyChain(apiKey: ApiKey) -> Completable
    
    func getApiKey() -> Single<ApiKey>
}

class AuthInteractor {
    
    // MARK: - Internal vars
    private let cacheWorker: AuthCacheWorkingLogic
    
    // MARK: - Init
    init(cacheWorker: AuthCacheWorkingLogic) {
        self.cacheWorker = cacheWorker
    }
}

extension AuthInteractor: AuthBusinessLogic {
    
    func saveToKeyChain(apiKey: ApiKey) -> Completable {
        return cacheWorker.saveToKeyChain(apiKey: apiKey)
    }
    
    func getApiKey() -> Single<ApiKey> {
        return cacheWorker.getApiKey()
    }
}
