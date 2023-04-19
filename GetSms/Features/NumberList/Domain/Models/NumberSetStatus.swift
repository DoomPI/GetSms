//
//  Status.swift
//  GetSms
//
//  Created by Роман Ломтев on 19.04.2023.
//

struct NumberSetStatus {
    let numberId: String
    let status: SetStatus
}

enum SetStatus {
    
    case Send
    
    case End
    
    case Bad
}
