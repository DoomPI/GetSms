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
            ScrollView {
                ForEach(vo.services.indices, id: \.self) { index in
                    ServiceView(
                        vo: vo.services[index],
                        pressAction: {
                            viewModel.purchaseNumber(
                                serviceCode: vo.services[index].code
                            )
                        }
                    )
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
                        code: "vk",
                        name: "VK - MailRu",
                        imageURL: URL(
                            string: "https://vak-sms.com/static/service/mr.png"
                        ),
                        quantity: "10 шт.",
                        cost: "17.00 ₽",
                        isLowQuantity: false
                    ),
                    ServiceVO(
                        code: "vk",
                        name: "VK - MailRu",
                        imageURL: URL(
                            string: "https://vak-sms.com/static/service/mr.png"
                        ),
                        quantity: "10 шт.",
                        cost: "17.00 ₽",
                        isLowQuantity: false
                    ),
                    ServiceVO(
                        code: "vk",
                        name: "VK - MailRu",
                        imageURL: URL(
                            string: "https://vak-sms.com/static/service/mr.png"
                        ),
                        quantity: "10 шт.",
                        cost: "17.00 ₽",
                        isLowQuantity: false
                    ),
                    ServiceVO(
                        code: "vk",
                        name: "VK - MailRu",
                        imageURL: URL(
                            string: "https://vak-sms.com/static/service/mr.png"
                        ),
                        quantity: "10 шт.",
                        cost: "17.00 ₽",
                        isLowQuantity: false
                    ),
                    ServiceVO(
                        code: "vk",
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
