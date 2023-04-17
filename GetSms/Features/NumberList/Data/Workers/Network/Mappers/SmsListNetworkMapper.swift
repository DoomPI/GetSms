//
//  SmsListNetworkMapper.swift
//  GetSms
//
//  Created by Роман Ломтев on 15.04.2023.
//

import Foundation

class SmsListNetworkMapper {
    
    func fromDto(dto: SmsListNetworkDTO) throws -> SmsList {
        if dto.error != nil {
            throw NSError(domain: "SmsListNetworkMapper", code: 1)
        }
        
        let data = dto.data ?? []
        
        return SmsList(
            data: data
        )
    }
}
