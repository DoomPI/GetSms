//
//  AuthView.swift
//  GetSms
//
//  Created by Роман Ломтев on 02.04.2023.
//

import SwiftUI

struct AuthView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var state: AuthState = .Idle
    @State private var errorState: ErrorState = .None
    
    var body: some View {
        ZStack {
            switch state {
                
            case .Idle:
                Spacer()
                
            case .Loaded:
                WebView(errorState: $errorState, url: "https://vak-sms.com/accounts/logout/?next=/accounts/login/", urlType: .Public)
                    .environmentObject(WebAssembly.assemble(
                        didCommit: viewModel.didCommit,
                        didFinish: viewModel.webViewDidFinish,
                        decidePolicyFor: viewModel.webViewDecidePolicyFor,
                        didFail: viewModel.webViewDidFail
                    ))
                
            case .BlockingLoading:
                AuthBlockingLoadingView()
                
            case .SuccessfulAuth:
                Spacer()
                
            case .FailedAuth:
                Spacer()
            }
        }
        .background(Color("DarkerBlueColor"))
        .edgesIgnoringSafeArea(.bottom)
        .onReceive(viewModel.$state) { newState in
            withAnimation {
                self.state = newState
            }
        }.onReceive(viewModel.$errorState) { newState in
            withAnimation {
                self.errorState = newState
        }
    }
    }
}
