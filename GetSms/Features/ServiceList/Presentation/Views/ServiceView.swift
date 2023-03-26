//
//  ServiceView.swift
//  GetSms
//
//  Created by Роман Ломтев on 26.03.2023.
//

import SwiftUI

struct ServiceView: View {
    
    // MARK: - External vars
    let vo: ServiceVO
    let pressAction: () -> Void
    let backgroundColor: Color
    
    // MARK: - Init
    init(
        vo: ServiceVO,
        pressAction: @escaping () -> Void
    ) {
        self.vo = vo
        self.pressAction = pressAction
        self.backgroundColor = vo.isLowQuantity
        ? Color("RedColor")
        : Color("GreenColor")
    }
    
    var body: some View {
        HStack(alignment: .center) {
            
            if vo.imageURL != nil {
                AsyncImage(url: vo.imageURL)
            } else {
                Image("ServiceNoImage")
            }
            
            VStack(alignment: .leading) {
                Text(vo.name)
                    .font(.system(size: 17))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                
                HStack(spacing: 12) {
                    Text(vo.cost)
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    Text(vo.quantity)
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
            }
            
            Spacer()
            
            Button(action: pressAction) {
                Text("ПОЛУЧИТЬ")
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
            .padding(4)
            .overlay(RoundedRectangle(cornerRadius: 5)
                .stroke(
                    Color("GreenColor"),
                    lineWidth: 1
                )
            )
        }
        .padding(16)
        .background(Rectangle()
            .fill(.linearGradient(
                colors: [
                    backgroundColor
                        .opacity(0.04),
                    backgroundColor
                        .opacity(0.33),
                    backgroundColor
                        .opacity(0.04)
                ],
                startPoint: .leading,
                endPoint: .trailing
            ))
            .cornerRadius(5)
        )
    }
}

struct ServiceView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ServiceView(
                vo: ServiceVO(
                    name: "VK - MailRu",
                    imageURL: URL(
                        string: "https://vak-sms.com/static/service/mr.png"
                    ),
                    quantity: "1 шт.",
                    cost: "17.00₽",
                    isLowQuantity: false
                ),
                pressAction: {}
            )
            
            Spacer()
        }
        .padding(1)
        .background(Color("DarkBlueColor"))
        .overlay(RoundedRectangle(cornerRadius: 5)
            .stroke(Color("PinkColor"), lineWidth: 1)
        )
    }
}
