//
//  AuthScreen.swift
//  GetSms
//
//  Created by Роман Ломтев on 02.04.2023.
//

import SwiftUI

struct AuthScreen: View {
    
    @ObservedObject var viewModel = AuthAssembly.assemble()
    
    @Binding var navigationState: NavigationState
    
    var body: some View {
        AuthView()
            .environmentObject(viewModel)
            .onReceive(viewModel.$state) { newState in
                if case .SuccessfulAuth = newState {
                    withAnimation {
                        navigationState = .ServiceList
                    }
                }
            }
    }
}
