//
//  ErrorMapper.swift
//  GetSms
//
//  Created by Рамиль Зиганшин on 24.05.2023.
//

import Foundation

func getPurchaseNumberError(from json: [String: Any]?) -> PurchaseNumberError {
    guard let error = json?["error"] as? String else {
        return .unknown // No error message found
    }
    
    switch error {
    case "apiKeyNotFound":
        return .apiKeyNotFound
    case "noService":
        return .noService
    case "noNumber":
        return .noNumber
    case "noMoney":
        return .noMoney
    case "noCountry":
        return .noCountry
    case "noOperator":
        return .noOperator
    case "badStatus":
        return .badStatus
    case "idNumNotFound":
        return .idNumNotFound
    case "badService":
        return .badService
    case "badData":
        return .badData
    default:
        return .unknown// Invalid error string
    }
}
