//
//  StatusNetworkMapper.swift
//  GetSms
//
//  Created by Роман Ломтев on 19.04.2023.
//

import Foundation

class StatusNetworkMapper {
    
    func fromDto(dto: GetStatusNetworkDTO) throws -> GetStatus {
        guard
            let statusString = dto.status
        else {
            throw NSError(domain: "StatusNetworkMapper", code: 1)
        }
        
        switch statusString {
            
        case "ready":
            return .Ready
            
        case "smsReceived":
            return .SmsReceived
            
        case "waitSMS":
            return .WaitSMS
            
        case "update":
            return .Update
            
        default:
            throw NSError(domain: "StatusNetworkMapper", code: 1)
        }
    }
    
    func toDto(model: SetStatus) -> SetStatusNetworkDTO {
        
        switch model {
            
        case .Send:
            return SetStatusNetworkDTO(status: "send")
            
        case .End:
            return SetStatusNetworkDTO(status: "end")
            
        case .Bad:
            return SetStatusNetworkDTO(status: "bad")
            
        }
    }
}
