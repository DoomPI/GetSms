//
//  ServiceListState.swift
//  GetSms
//
//  Created by Роман Ломтев on 25.03.2023.
//

enum ServiceListState {
    
    case Loading
    
    case Loaded(vo: ServiceListVO)
    
    case Error(vo: ServiceListErrorVO)
    
    case ProceededToNumbersList
    
    case BlockingLoading
}
