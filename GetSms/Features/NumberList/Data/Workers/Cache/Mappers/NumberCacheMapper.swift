//
//  NumberListCacheDTO.swift
//  GetSms
//
//  Created by Роман Ломтев on 15.04.2023.
//

import Foundation

class NumberCacheMapper {
    
    func fromDto(dto: [NumberCacheDTO]) throws -> [Number] {
        return try dto.map { numberDto in
            try fromDto(dto: numberDto)
        }
    }
    
    func toDto(model: [Number]) -> [NumberCacheDTO] {
        return model.map { number in
            toDto(model: number)
        }
    }
    
    private func fromDto(dto: NumberCacheDTO) throws -> Number {
        guard
            let serviceName = dto.serviceName,
            let id = dto.id,
            let phoneNumber = dto.phoneNumber
        else {
            throw NSError(domain: "NumberCacheMapper", code: 1)
        }
        
        return Number(
            serviceName: serviceName,
            id: id,
            phoneNumber: phoneNumber
        )
    }
    
    private func toDto(model: Number) -> NumberCacheDTO {
        let serviceName = model.serviceName
        let id = model.id
        let phoneNumber = model.phoneNumber
        
        return NumberCacheDTO(
            serviceName: serviceName,
            id: id,
            phoneNumber: phoneNumber
        )
    }
}
