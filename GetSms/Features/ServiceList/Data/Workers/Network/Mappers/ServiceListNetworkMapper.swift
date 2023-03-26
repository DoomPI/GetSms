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
        let data = Array(dto.values).map { serviceDto in
            fromDto(dto: serviceDto[0])
        }
        
        return ServiceList(data: data)
    }
    
    private func fromDto(dto: ServiceNetworkDTO) -> Service {
        let name = dto.name!
        let imageURL = dto.imageURL != nil ? URL(string: Self.url + dto.imageURL!) : nil
        let quantity = dto.quantity!
        let info = dto.info
        let cost = dto.cost!
        
        return Service(
            name: name,
            imageURL: imageURL,
            quantity: quantity,
            info: info,
            cost: cost
        )
    }
}
