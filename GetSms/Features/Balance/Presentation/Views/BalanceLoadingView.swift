//
//  BalanceLoadingView.swift
//  GetSms
//
//  Created by Роман Ломтев on 10.04.2023.
//

import SwiftUI

struct BalanceLoadingView: View {
    
    @EnvironmentObject var viewModel: BalanceViewModel
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button(action: viewModel.logout) {
                    Image("SignoutImage")
                }
            }
            
            HStack(alignment: .center) {
                
                BalanceImage()
                
                VStack(alignment: .leading) {
                    Text("Баланс:")
                        .font(.system(size: 15))
                    
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 50, height: 14)
                }
                .padding(4)
                
                Spacer()
                
                Button(action: {
                    viewModel.proceedToPayment()
                }) {
                    Text("ПОПОЛНИТЬ")
                        .font(.system(size: 12))
                        .fontWeight(.bold)
                }
                .padding(4)
                .overlay(RoundedRectangle(cornerRadius: 5)
                    .stroke(
                        lineWidth: 1
                    )
                )
            }
            .frame(height: 60)
        }
        .shimmer(
            tint: .gray.opacity(0.3),
            highlight: .white,
            blur: 5
        )
    }
}

struct BalanceLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceLoadingView()
        .background(Color("DarkBlueColor"))
    }
}
