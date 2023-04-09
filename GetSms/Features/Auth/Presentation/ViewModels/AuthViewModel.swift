//
//  AuthViewModel.swift
//  GetSms
//
//  Created by Роман Ломтев on 02.04.2023.
//

import SwiftUI

protocol AuthHandlerProtocol: Handler where Intent == AuthIntent {
}

class AuthViewModel: ObservableObject {
    
    @Published private(set) var state: AuthState = .Loading
    
}

extension AuthViewModel: AuthHandlerProtocol {
    
    func handle(intent: Intent) {
        
    }
}
