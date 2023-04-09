//
//  AuthView.swift
//  GetSms
//
//  Created by Роман Ломтев on 02.04.2023.
//

import SwiftUI

struct AuthView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
        WebView(url: "https://vak-sms.com/accounts/logout/?next=/lk/", urlType: .Public)
            .environmentObject(WebAssembly.assemble(didFinish: viewModel.webViewDidFinish))
            .edgesIgnoringSafeArea(.bottom)
    }
}
