//
//  PaymentScreen.swift
//  GetSms
//
//  Created by Роман Ломтев on 11.04.2023.
//

import SwiftUI

struct PaymentScreen: View {
    
    @ObservedObject var viewModel = PaymentAssembly.assemble()
    
    var body: some View {
        PaymentView()
            .environmentObject(viewModel)
            .onReceive(viewModel.$state) { newState in
                switch newState {
                    
                case .Idle:
                    break
                    
                }
            }
    }
}
