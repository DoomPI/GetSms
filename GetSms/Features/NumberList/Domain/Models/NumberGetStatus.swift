//
//  NumberGetStatus.swift
//  GetSms
//
//  Created by Роман Ломтев on 19.04.2023.
//

struct NumberGetStatus {
    let numberId: String
    let status: GetStatus
}

enum GetStatus {
    
    case Ready
    
    case SmsReceived
    
    case WaitSMS
    
    case Update
}

