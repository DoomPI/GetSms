//
//  CountryListNetworkMapper.swift
//  GetSms
//
//  Created by Роман Ломтев on 01.04.2023.
//

import Foundation

class CountryListNetworkMapper {
    
    private static let url = "https://vak-sms.com"
    
    func fromDto(dto: CountryListNetworkDTO) -> CountryList {
        let countries = dto.keys.indices.map { index in
            let countryCode = dto.keys[index].lowercased()
            let countryDto = dto.values[index][0]
            return fromDto(
                code: countryCode,
                dto: countryDto
            )
        }
        
        return CountryList(countries: countries)
    }
    
    private func fromDto(code: String, dto: CountryNetworkDTO) -> Country {
        let name = dto.name!
        let imageURL = dto.imageURL != nil ? URL(string: Self.url + dto.imageURL!) : nil
        
        return Country(
            code: code,
            name: name,
            imageURL: imageURL
        )
    }
}
