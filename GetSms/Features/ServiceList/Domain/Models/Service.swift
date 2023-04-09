//
//  Service.swift
//  GetSms
//
//  Created by Роман Ломтев on 25.03.2023.
//

import Foundation

struct Service {
    let code: String
    let name: String
    let imageURL: URL?
    let quantity: Int
    let isLowQuantity: Bool
    let info: String?
    let cost: Float
}
