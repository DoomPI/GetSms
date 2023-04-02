//
//  ServiceListNetworkMapper.swift
//  GetSms
//
//  Created by Роман Ломтев on 26.03.2023.
//

import Foundation

class ServiceListNetworkMapper {
    
    private static let url = "https://vak-sms.com"
    
    func fromDto(dto: ServiceListNetworkDTO) -> ServiceList {
        let services = dto.keys.indices.map { index in
            let serviceCode = dto.keys[index]
            let serviceDto = dto.values[index][0]
            return fromDto(
                code: serviceCode,
                dto: serviceDto
            )
        }
        
        return ServiceList(services: services)
    }
    
    private func fromDto(code: String, dto: ServiceNetworkDTO) -> Service {
        let name = dto.name!
        let imageURL = dto.imageURL != nil ? URL(string: Self.url + dto.imageURL!) : nil
        let quantity = dto.quantity!
        let info = dto.info
        let cost = dto.cost!
        
        return Service(
            code: code,
            name: name,
            imageURL: imageURL,
            quantity: quantity,
            info: info,
            cost: cost
        )
    }
}
