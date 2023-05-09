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
    @State private var errorState: ErrorState = .None

    private static let payUrl: String = "https://vak-sms.com/pay/"
    
    var body: some View {
        ZStack {
            switch state {
                
            case .Idle:
                Spacer()
                
            case .Opened:
                WebView(errorState: $errorState, url: Self.payUrl, urlType: .Public)
                    .environmentObject(WebAssembly.assemble(
                        didCommit: viewModel.webViewDidCommit,
                        didFinish: viewModel.webViewDidFinish,
                        decidePolicyFor: viewModel.webViewDecidePolicyFor,
                        didFail: viewModel.webViewDidFail
                        
                    ))
            case .Closed:
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
