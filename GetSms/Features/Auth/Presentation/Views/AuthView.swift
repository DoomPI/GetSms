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
    
    var body: some View {
        ZStack {
            switch state {
                
            case .Idle:
                Spacer()
                
            case .Loaded:
                WebView(url: "https://vak-sms.com/accounts/logout/?next=/accounts/login/", urlType: .Public)
                    .environmentObject(WebAssembly.assemble(
                        didCommit: viewModel.didCommit,
                        didFinish: viewModel.webViewDidFinish,
                        decidePolicyFor: viewModel.webViewDecidePolicyFor
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
        }
    }
}
