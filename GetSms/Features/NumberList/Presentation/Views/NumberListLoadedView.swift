//
//  NumberListLoadedView.swift
//  GetSms
//
//  Created by Роман Ломтев on 16.04.2023.
//

import SwiftUI

struct NumberListLoadedView: View {
    
    @EnvironmentObject var viewModel: NumberListViewModel
    
    let vo: NumberDataListVO
    
    var body: some View {
        VStack {
            ScrollView {
                if vo.numbers.isEmpty {
                    
                    Text("Нет арендованных номеров")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    
                } else {
                    
                    ForEach(vo.numbers.indices, id: \.self) { index in
                        NumberView(
                            vo: vo.numbers[index],
                            bannedPressAction: {},
                            cancelPressAction: {}
                        )
                    }
                }
            }
            .refreshable {
                viewModel.loadNumberList()
            }
            
            Spacer()
        }
    }
}

struct NumberListLoadedView_Previews: PreviewProvider {
    static var previews: some View {
        NumberListLoadedView(vo: NumberDataListVO(
            numbers: [
                NumberDataVO(
                    number: NumberVO(
                        serviceName: "VK - MailRu",
                        number: "+70001234567"
                    ),
                    smsList: SmsList(data: []),
                    backgroundColorRes: "YellowColor"
                ),
                NumberDataVO(
                    number: NumberVO(
                        serviceName: "VK - MailRu",
                        number: "+70001234567"
                    ),
                    smsList: SmsList(data: []),
                    backgroundColorRes: "YellowColor"
                ),
                NumberDataVO(
                    number: NumberVO(
                        serviceName: "VK - MailRu",
                        number: "+70001234567"
                    ),
                    smsList: SmsList(data: []),
                    backgroundColorRes: "YellowColor"
                ),
                NumberDataVO(
                    number: NumberVO(
                        serviceName: "VK - MailRu",
                        number: "+70001234567"
                    ),
                    smsList: SmsList(data: []),
                    backgroundColorRes: "YellowColor"
                ),
                NumberDataVO(
                    number: NumberVO(
                        serviceName: "VK - MailRu",
                        number: "+70001234567"
                    ),
                    smsList: SmsList(data: []),
                    backgroundColorRes: "YellowColor"
                )
            ]
        ))
        .background(Color("DarkBlueColor"))
    }
}
