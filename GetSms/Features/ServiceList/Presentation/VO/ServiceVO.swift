//
//  ServiceVO.swift
//  GetSms
//
//  Created by Роман Ломтев on 26.03.2023.
//

import Foundation

struct ServiceVO {
    let code: String
    let name: String
    let imageURL: URL?
    let quantity: String
    let cost: String
    let isLowQuantity: Bool
    
    init(
        code: String,
        name: String,
        imageURL: URL?,
        quantity: String,
        cost: String,
        isLowQuantity: Bool
    ) {
        self.code = code
        self.name = name
        self.imageURL = imageURL
        self.quantity = quantity
        self.cost = cost
        self.isLowQuantity = isLowQuantity
    }
}
