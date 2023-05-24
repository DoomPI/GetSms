//
//  PurchaseNumberError.swift
//  GetSms
//
//  Created by Рамиль Зиганшин on 24.05.2023.
//

import Foundation

enum PurchaseNumberError: Error {
    case apiKeyNotFound
    case noService
    case noNumber
    case noMoney
    case noCountry
    case noOperator
    case badStatus
    case idNumNotFound
    case badService
    case badData
    case unknown

    var localizedDescription: String {
        switch self {
        case .apiKeyNotFound:
            return "Неверный API ключ."
        case .noService:
            return "Данный сервис не поддерживается, свяжитесь с администрацией сайта."
        case .noNumber:
            return "Нет номеров, попробуйте позже."
        case .noMoney:
            return "Недостаточно средств, пополните баланс."
        case .noCountry:
            return "Запрашиваемая страна отсутствует."
        case .noOperator:
            return "Оператор не найден для запрашиваемой страны."
        case .badStatus:
            return "Не верный статус."
        case .idNumNotFound:
            return "Не верный ID операции."
        case .badService:
            return "Не верный код сайта, сервиса, соц. сети."
        case .badData:
            return "Отправлены неверные данные."
        case .unknown:
            return "Неизвестная ошибка"
        }
    }
}
