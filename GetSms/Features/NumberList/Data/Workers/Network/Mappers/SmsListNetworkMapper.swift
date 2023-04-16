//
//  SmsListNetworkMapper.swift
//  GetSms
//
//  Created by Роман Ломтев on 15.04.2023.
//

import Foundation

class SmsListNetworkMapper {
    
    func fromDto(dto: SmsListNetworkDTO) throws -> SmsList {
        guard
            let data = dto.data
        else {
            throw NSError(domain: "SmsListNetworkMapper", code: 1)
        }
        
        return SmsList(
            data: data
        )
    }
}
