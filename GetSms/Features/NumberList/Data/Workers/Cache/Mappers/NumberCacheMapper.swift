//
//  NumberListCacheDTO.swift
//  GetSms
//
//  Created by Роман Ломтев on 15.04.2023.
//

import Foundation

class NumberCacheMapper {
    
    func fromDto(dto: [NumberCacheDTO]) -> [Number] {
        return dto.map { numberDto in
            fromDto(dto: numberDto)
        }
    }
    
    func toDto(model: [Number]) -> [NumberCacheDTO] {
        return model.map { number in
            toDto(model: number)
        }
    }
    
    private func fromDto(dto: NumberCacheDTO) -> Number {
        let id = dto.id!
        let phoneNumber = dto.phoneNumber!
        
        return Number(
            id: id,
            phoneNumber: phoneNumber
        )
    }
    
    private func toDto(model: Number) -> NumberCacheDTO {
        let id = model.id
        let phoneNumber = model.phoneNumber
        
        return NumberCacheDTO(
            id: id,
            phoneNumber: phoneNumber
        )
    }
}
