//
//  AuthAssembly.swift
//  GetSms
//
//  Created by Роман Ломтев on 09.04.2023.
//

import Foundation

enum AuthAssembly {
    
    static func assemble() -> AuthViewModel {
        let processor = AuthProcessor()
        let reducer = AuthReducer()
        
        let cacheWorker = AuthCacheWorker()
        let interactor = AuthInteractor(
            cacheWorker: cacheWorker
        )
        
        let viewModel = AuthViewModel(
            processor: processor,
            reducer: reducer,
            interactor: interactor
        )
        processor.handler = viewModel
        
        return viewModel
    }
}
