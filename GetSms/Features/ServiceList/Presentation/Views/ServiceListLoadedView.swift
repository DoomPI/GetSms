//
//  ServiceListLoadedView.swift
//  GetSms
//
//  Created by Роман Ломтев on 10.04.2023.
//

import SwiftUI

struct ServiceListLoadedView: View {
    
    @EnvironmentObject var viewModel: ServiceListViewModel
    
    let vo: ServiceListVO
    
    var body: some View {
        VStack {
            ServiceSearchView(onTextChanged: { inputText in
                viewModel.searchService(inputText: inputText)
            })
            
            ScrollView {
                ForEach(vo.services.indices, id: \.self) { index in
                    ServiceView(vo: vo.services[index], pressAction: {})
                }
            }
            .refreshable {
                viewModel.loadServiceList()
            }
        }
    }
}

struct ServiceListLoadedView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceListLoadedView(
            vo: ServiceListVO(
                services: [
                    ServiceVO(
                        name: "VK - MailRu",
                        imageURL: URL(
                            string: "https://vak-sms.com/static/service/mr.png"
                        ),
                        quantity: "10 шт.",
                        cost: "17.00 ₽",
                        isLowQuantity: false
                    ),
                    ServiceVO(
                        name: "VK - MailRu",
                        imageURL: URL(
                            string: "https://vak-sms.com/static/service/mr.png"
                        ),
                        quantity: "10 шт.",
                        cost: "17.00 ₽",
                        isLowQuantity: false
                    ),
                    ServiceVO(
                        name: "VK - MailRu",
                        imageURL: URL(
                            string: "https://vak-sms.com/static/service/mr.png"
                        ),
                        quantity: "10 шт.",
                        cost: "17.00 ₽",
                        isLowQuantity: false
                    ),
                    ServiceVO(
                        name: "VK - MailRu",
                        imageURL: URL(
                            string: "https://vak-sms.com/static/service/mr.png"
                        ),
                        quantity: "10 шт.",
                        cost: "17.00 ₽",
                        isLowQuantity: false
                    ),
                    ServiceVO(
                        name: "VK - MailRu",
                        imageURL: URL(
                            string: "https://vak-sms.com/static/service/mr.png"
                        ),
                        quantity: "10 шт.",
                        cost: "17.00 ₽",
                        isLowQuantity: false
                    )
                ]
            )
        )
        .background(Color("DarkBlueColor"))
    }
}
