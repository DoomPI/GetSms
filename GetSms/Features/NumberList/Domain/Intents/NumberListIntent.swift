//
//  NumberListIntent.swift
//  GetSms
//
//  Created by Роман Ломтев on 16.04.2023.
//

enum NumberListIntent {
    
    case LoadList
    
    case PresentList(model: NumberDataList)
    
    case PresentError(error: Error)
}
