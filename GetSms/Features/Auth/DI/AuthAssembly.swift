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
        
        let viewModel = AuthViewModel(
            processor: processor,
            reducer: reducer
        )
        processor.handler = viewModel
        
        return viewModel
    }
}
