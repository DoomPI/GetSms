//
//  AuthView.swift
//  GetSms
//
//  Created by Роман Ломтев on 02.04.2023.
//

import SwiftUI

struct AuthView: View {
    
    @State private var state: AuthState = .Loading
    
    var body: some View {
        
        WebView(url: "https://vak-sms.com/accounts/login/", urlType: .Public)
            .environmentObject(WebAssembly.assemble())
            .edgesIgnoringSafeArea(.bottom)
        //        .onReceive(viewModel.$state) { newState in
        //            state = newState
        //        }
    }
}
