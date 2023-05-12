//
//  WebView.swift
//  GetSms
//
//  Created by Роман Ломтев on 09.04.2023.
//

import SwiftUI

struct WebView: View {
    
    @EnvironmentObject var viewModel: WebViewModel
    @Binding var errorState: ErrorState
    
    var url: String
    var urlType: URLType
    
    var body: some View {
        VStack {
            WebNavigationView(
                goForwardAction: viewModel.forward,
                goBackwardAction: viewModel.backward,
                reloadAction: viewModel.reload
            )
            
            WebContentView(url: url, urlType: urlType)
                .environmentObject(viewModel)
                    .overlay (
                        ErrorView(errorState: $errorState)
                    )
        }
        .background(Color("DarkerBlueColor"))
        .onAppear {
            viewModel.onViewAppear()
        }.onReceive(viewModel.$errorState){ newState in
            withAnimation{
                self.errorState = newState
            }
        }
    }
}
