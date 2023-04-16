//
//  NumberNetworkDTOMapper.swift
//  GetSms
//
//  Created by Роман Ломтев on 15.04.2023.
//

class NumberNetworkMapper {
    
    func fromDto(dto: NumberNetworkDTO) -> Number {
        let id = dto.id!
        let phoneNumber = dto.phoneNumber!
        
        return Number(
            id: id,
            phoneNumber: phoneNumber
        )
    }
}
