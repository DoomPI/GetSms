//
//  CountryListProcessor.swift
//  GetSms
//
//  Created by Роман Ломтев on 01.04.2023.
//

enum CountryListIntent {
    
    case LoadList
    
    case PresentList(model: CountryList)
    
    case PresentError(error: Error)
}
