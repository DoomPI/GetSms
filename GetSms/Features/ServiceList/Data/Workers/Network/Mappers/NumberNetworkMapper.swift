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

        return Number(
            serviceName: serviceName,
            id: dto.id,
            phoneNumber: dto.phoneNumber
        )
    }
}
