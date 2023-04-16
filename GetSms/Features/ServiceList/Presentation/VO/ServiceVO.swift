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
    let backgroundColorRes: String
    
    init(
        code: String,
        name: String,
        imageURL: URL?,
        quantity: String,
        cost: String,
        backgroundColorRes: String
    ) {
        self.code = code
        self.name = name
        self.imageURL = imageURL
        self.quantity = quantity
        self.cost = cost
        self.backgroundColorRes = backgroundColorRes
    }
}
