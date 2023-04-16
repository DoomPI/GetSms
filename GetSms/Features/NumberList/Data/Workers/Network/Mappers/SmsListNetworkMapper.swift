//
//  SmsListNetworkMapper.swift
//  GetSms
//
//  Created by Роман Ломтев on 15.04.2023.
//

class SmsListNetworkMapper {
    
    func fromDto(dto: SmsListNetworkDTO) -> SmsList {
        let data = dto.data!
        
        return SmsList(
            data: data
        )
    }
}
