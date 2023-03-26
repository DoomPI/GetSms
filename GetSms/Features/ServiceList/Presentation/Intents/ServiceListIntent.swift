//
//  ServiceListIntent.swift
//  GetSms
//
//  Created by Роман Ломтев on 25.03.2023.
//

enum ServiceListIntent {
    
    case LoadList
    
    case ShowList(vo: ServiceListVO)
    
    case ShowError(vo: ServiceListErrorVO)
}
