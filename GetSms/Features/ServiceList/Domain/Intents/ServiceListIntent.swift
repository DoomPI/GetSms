//
//  ServiceListIntent.swift
//  GetSms
//
//  Created by Роман Ломтев on 25.03.2023.
//

enum ServiceListIntent {
    
    case LoadList
    
    case PresentList(model: ServiceList)
    
    case PresentError(error: Error)
}
