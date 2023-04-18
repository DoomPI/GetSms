//
//  ServiceListIntent.swift
//  GetSms
//
//  Created by Роман Ломтев on 25.03.2023.
//

enum ServiceListIntent {
    
    case Nothing
    
    case LoadList(countryCode: String? = nil)
    
    case SearchService(searchText: String)
    
    case PresentList(model: ServiceList)
    
    case PresentError(error: Error)
    
    case PurchaseNumber(serviceCode: String, serviceName: String)
    
    case ProceedToNumbersList
    
    case PresentBlockingLoading
}
