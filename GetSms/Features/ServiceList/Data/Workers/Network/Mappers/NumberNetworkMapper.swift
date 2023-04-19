//
//  NumberNetworkDTOMapper.swift
//  GetSms
//
//  Created by Роман Ломтев on 15.04.2023.
//

import Foundation

class NumberNetworkMapper {
    
    func fromDto(
        serviceName: String,
        dto: NumberNetworkDTO
    ) throws -> Number {
        guard
            let id = dto.id,
            let phoneNumber = dto.phoneNumber
        else {
            throw NSError(domain: "NumberNetworkMapper", code: 1)
        }
        
        return Number(
            serviceName: serviceName,
            id: id,
            phoneNumber: phoneNumber
        )
    }
}
