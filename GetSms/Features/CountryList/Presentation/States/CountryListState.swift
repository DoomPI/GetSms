//
//  CountryListState.swift
//  GetSms
//
//  Created by Роман Ломтев on 01.04.2023.
//

enum CountryListState {
    
    case Idle
    
    case Loading
    
    case Loaded(vo: CountryListVO)
    
    case Error(vo: CountryListErrorVO)
}
