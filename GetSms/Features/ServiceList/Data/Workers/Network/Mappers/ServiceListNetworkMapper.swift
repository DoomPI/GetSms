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
    ) throws -> ServiceList {
        let services = try dto.keys.indices.map { index in
            let serviceCode = dto.keys[index].lowercased()
            let serviceDto = dto.values[index][0]
            return try fromDto(
                code: serviceCode,
                dto: serviceDto
            )
        }
        
        return ServiceList(
            services: services,
            countryCode: countryCode
        )
    }
    
    private func fromDto(code: String, dto: ServiceNetworkDTO) throws -> Service {
        guard
            let name = dto.name,
            let quantity = dto.quantity,
            let cost = dto.cost
        else {
            throw NSError(domain: "ServiceListNetworkMapper", code: 1)
        }
        let imageURL = getImageURL(dtoImageURL: dto.imageURL)
        let info = dto.info
        let isLowQuantity = quantity < 10
        
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
    
    private func getImageURL(dtoImageURL: String?) -> URL? {
        guard
            let dtoImageURL,
            let url = URL(string: Self.url + dtoImageURL)
        else {
            return nil
        }
        
        return url
    }
}
