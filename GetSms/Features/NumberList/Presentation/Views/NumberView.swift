//
//  NumberView.swift
//  GetSms
//
//  Created by Роман Ломтев on 16.04.2023.
//

import SwiftUI

struct NumberView: View {
    
    // MARK: - External vars
    let vo: NumberDataVO
    let cancelPressAction: () -> Void
    
    // MARK: - Internval vars
    private let backgroundColor: Color
    
    // MARK: - Init
    init(
        vo: NumberDataVO,
        cancelPressAction: @escaping () -> Void
    ) {
        self.vo = vo
        self.cancelPressAction = cancelPressAction
        self.backgroundColor = Color(vo.backgroundColorRes)
    }
    
    var body: some View {
        HStack(alignment: .center) {
            
            VStack(alignment: .leading) {
                Text(vo.number.serviceName)
                    .font(.system(size: 17))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                
                Text(vo.number.number)
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
            
            Spacer()
            
            SmsInfoView(
                smsList: vo.smsList
            )
            
            Spacer()
            
            Button(action: cancelPressAction) {
                Text("ОТМЕНА")
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
        .frame(height: 40)
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

struct SmsInfoView: View {
    
    let smsList: SmsList
    
    var body: some View {
        
        Text(
            smsList.data.isEmpty
            ? "Ожидает SMS"
            : smsList.data[0]
        )
        .font(.system(size: 15))
        .foregroundColor(.white)
        .fontWeight(.bold)
    }
}

struct NumberView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            NumberView(
                vo: NumberDataVO(
                    number: NumberVO(
                        serviceName: "VK - MailRu",
                        id: "",
                        number: "+70001234567"
                    ),
                    smsList: SmsList(data: []),
                    backgroundColorRes: "YellowColor"
                ),
                cancelPressAction: {}
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
