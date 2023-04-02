//
//  ServiceVO.swift
//  GetSms
//
//  Created by Роман Ломтев on 26.03.2023.
//

import Foundation

struct ServiceVO {
    let name: String
    let imageURL: URL?
    let quantity: String
    let cost: String
    let isLowQuantity: Bool
    
    init(
        name: String,
        imageURL: URL?,
        quantity: String,
        cost: String,
        isLowQuantity: Bool
    ) {
        self.name = name
        self.imageURL = imageURL
        self.quantity = quantity
        self.cost = cost
        self.isLowQuantity = isLowQuantity
    }
    
    static let empty = ServiceVO(
        name: "Название сервиса",
        imageURL: nil,
        quantity: "0 шт.",
        cost: "0.00₽",
        isLowQuantity: false
    )
}
