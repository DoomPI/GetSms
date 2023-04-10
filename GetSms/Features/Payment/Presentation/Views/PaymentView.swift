//
//  PaymentView.swift
//  GetSms
//
//  Created by Роман Ломтев on 11.04.2023.
//

import SwiftUI

struct PaymentView: View {
    
    @EnvironmentObject var viewModel: PaymentViewModel
    
    @State private var state: PaymentState = .Idle
    
    var body: some View {
        ZStack {
            switch state {
                
            case .Idle:
                WebView(url: "https://vak-sms.com/pay/", urlType: .Public)
                    .environmentObject(WebAssembly.assemble(
                        didFinish: viewModel.webViewDidFinish,
                        decidePolicyFor: viewModel.webViewDecidePolicyFor
                    ))
            }
        }
        .background(Color("DarkerBlueColor"))
        .edgesIgnoringSafeArea(.bottom)
        .onReceive(viewModel.$state) { newState in
            withAnimation {
                self.state = newState
            }
        }
        .onAppear {
            viewModel.onViewAppear()
        }
    }
}

