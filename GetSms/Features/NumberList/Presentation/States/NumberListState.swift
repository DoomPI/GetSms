//
//  NumberListState.swift
//  GetSms
//
//  Created by Роман Ломтев on 16.04.2023.
//

enum NumberListState {
    
    case Loading
    
    case Loaded(vo: NumberDataListVO)
    
    case Error
}
