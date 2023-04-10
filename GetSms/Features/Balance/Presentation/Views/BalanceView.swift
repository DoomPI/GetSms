//
//  BalanceView.swift
//  GetSms
//
//  Created by Роман Ломтев on 10.04.2023.
//

import SwiftUI

struct BalanceView: View {
    
    @EnvironmentObject var viewModel: BalanceViewModel
    
    @State private var state: BalanceState = .Loading
    
    var body: some View {
        VStack {
            switch state {
                
            case .Loading:
                BalanceLoadingView(
                    pressAction: viewModel.proceedToPayment
                )
                
            case .Loaded(let vo):
                BalanceLoadedView(
                    vo: vo,
                    pressAction: viewModel.proceedToPayment
                )
                
            case .Error:
                BalanceErrorView()
                
            case .ProceededToPayment:
                BalanceLoadingView(
                    pressAction: {}
                )
                
            }
        }
        .background(Color("DarkBlueColor"))
        .onReceive(viewModel.$state) { newState in
            self.state = newState
        }
        .onAppear {
            viewModel.onViewAppear()
        }
    }
}
