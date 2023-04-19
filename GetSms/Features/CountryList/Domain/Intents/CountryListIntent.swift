//
//  CountryListProcessor.swift
//  GetSms
//
//  Created by Роман Ломтев on 01.04.2023.
//

enum CountryListIntent {
    
    case LoadList
    
    case PresentList(model: CountryList)
    
    case SelectCountry(countryCode: String)
    
    case PresentError(error: Error)
    
    case PresentBlockingLoading
}
