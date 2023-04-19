//
//  BalanceLoadedView.swift
//  GetSms
//
//  Created by Роман Ломтев on 10.04.2023.
//

import SwiftUI

struct BalanceLoadedView: View {
    
    @EnvironmentObject var viewModel: BalanceViewModel
    
    let vo: BalanceVO
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button(action: viewModel.logout) {
                    Image("SignoutImage")
                }
            }
            
            HStack(alignment: .center) {
                
                Button(action: {
                    viewModel.reloadBalance()
                }) {
                    HStack {
                        BalanceImage()
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Баланс:")
                                .font(.system(size: 15))
                                .foregroundColor(Color("LilacColor"))
                            
                            Text(vo.balance)
                                .font(.system(size: 16))
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                        }
                        .padding(4)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    viewModel.proceedToPayment()
                }) {
                    Text("ПОПОЛНИТЬ")
                        .font(.system(size: 12))
                        .foregroundColor(
                            Color("GreenColor")
                        )
                        .fontWeight(.bold)
                }
                .padding(4)
                .overlay(RoundedRectangle(cornerRadius: 5)
                    .stroke(
                        Color("LilacColor"),
                        lineWidth: 1
                    )
                )
            }
            .frame(height: 60)
        }
    }
}


struct BalanceLoadedView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceLoadedView(
            vo: BalanceVO(balance: "0.00 р.")
        )
        .background(Color("DarkBlueColor"))
    }
}
