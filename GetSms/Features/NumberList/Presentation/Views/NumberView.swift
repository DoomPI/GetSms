//
//  NumberView.swift
//  GetSms
//
//  Created by Роман Ломтев on 16.04.2023.
//

import SwiftUI
import UniformTypeIdentifiers

struct NumberView: View {
    
    // MARK: - External vars
    let vo: NumberDataVO
    let cancelPressAction: () -> Void
    let continuePressAction: () -> Void
    
    // MARK: - Internval vars
    private let backgroundColor: Color
    
    // MARK: - Init
    init(
        vo: NumberDataVO,
        cancelPressAction: @escaping () -> Void,
        continuePressAction: @escaping () -> Void
    ) {
        self.vo = vo
        self.cancelPressAction = cancelPressAction
        self.continuePressAction = continuePressAction
        self.backgroundColor = Color(vo.backgroundColorRes)
    }
    
    var body: some View {
        HStack(alignment: .center) {
            
            VStack(alignment: .leading) {
                Text(vo.number.serviceName)
                    .font(.system(size: 17))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                
                Button(action: {
                    UIPasteboard.general.setValue(
                        vo.number.number,
                        forPasteboardType: UTType.plainText.identifier
                    )
                }) {
                    Text(vo.number.number)
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
            }
            
            Spacer()
            
            SmsInfoView(
                smsList: vo.smsList
            )
            
            Spacer()
            
            ButtonsSection(
                cancelPressAction: cancelPressAction,
                vo: vo
            )
        }
        .padding(8)
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
        
        Button(action: {
            if !smsList.data.isEmpty {
                UIPasteboard.general.setValue(
                    smsList.data[0],
                    forPasteboardType: UTType.plainText.identifier
                )
            }
        }) {
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
}

struct ButtonsSection: View {
    
    let cancelPressAction: () -> Void
    let vo: NumberDataVO
    
    var body: some View {
        
        if vo.smsList.data.isEmpty {
            Button(action: cancelPressAction) {
                Text("ОТМЕНА")
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
            .padding(4)
            .overlay(RoundedRectangle(cornerRadius: 5)
                .stroke(
                    Color("RedColor"),
                    lineWidth: 1
                )
            )
        } else {
            VStack {
                Button(action: {}) {
                    Text("ПОЛУЧИТЬ ЕЩЁ")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
                .padding(4)
                .frame(maxWidth: .infinity)
                .overlay(RoundedRectangle(cornerRadius: 5)
                    .stroke(
                        Color("GreenColor"),
                        lineWidth: 1
                    )
                )
                
                Button(action: cancelPressAction) {
                    Text("ОТМЕНА")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
                .padding(4)
                .frame(maxWidth: .infinity)
                .overlay(RoundedRectangle(cornerRadius: 5)
                    .stroke(
                        Color("RedColor"),
                        lineWidth: 1
                    )
                )
            }
            .fixedSize(horizontal: true, vertical: false)
        }
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
                cancelPressAction: {},
                continuePressAction: {}
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
