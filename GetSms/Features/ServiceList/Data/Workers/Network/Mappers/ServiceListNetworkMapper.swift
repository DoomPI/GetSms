//
//  ServiceListNetworkMapper.swift
//  GetSms
//
//  Created by Роман Ломтев on 26.03.2023.
//

import Foundation

class ServiceListNetworkMapper {
    
    private static let url = "https://vak-sms.com"
    
    func fromDto(
        dto: ServiceListNetworkDTO,
        countryCode: String
    ) -> ServiceList {
        let services = dto.keys.indices.map { index in
            let serviceCode = dto.keys[index]
            let serviceDto = dto.values[index][0]
            return fromDto(
                code: serviceCode,
                dto: serviceDto
            )
        }
        
        return ServiceList(
            services: services,
            countryCode: countryCode
        )
    }
    
    private func fromDto(code: String, dto: ServiceNetworkDTO) -> Service {
        let name = dto.name!
        let imageURL = dto.imageURL != nil ? URL(string: Self.url + dto.imageURL!) : nil
        let quantity = dto.quantity!
        let isLowQuantity = quantity < 10
        let info = dto.info
        let cost = dto.cost!
        
        return Service(
            code: code,
            name: name,
            imageURL: imageURL,
            quantity: quantity,
            isLowQuantity: isLowQuantity,
            info: info,
            cost: cost
        )
    }
}
