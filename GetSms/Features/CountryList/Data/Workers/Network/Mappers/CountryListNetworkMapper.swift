//
//  CountryListNetworkMapper.swift
//  GetSms
//
//  Created by Роман Ломтев on 01.04.2023.
//

import Foundation

class CountryListNetworkMapper {
    
    private static let url = "https://vak-sms.com"
    private static let defaultSelectedCountryCode = "ru"
    
    func fromDto(dto: CountryListNetworkDTO) throws -> CountryList {
        let countries = try dto.keys.indices.map { index in
            let countryCode = dto.keys[index].lowercased()
            let countryDto = dto.values[index][0]
            return try fromDto(
                code: countryCode,
                dto: countryDto
            )
        }
        let selectedCountryIndex = countries.firstIndex(where: { country in
            country.code == Self.defaultSelectedCountryCode
        }) ?? 0
        
        return CountryList(
            countries: countries,
            selectedCountryIndex: selectedCountryIndex
        )
    }
    
    private func fromDto(code: String, dto: CountryNetworkDTO) throws -> Country {
        guard
            let name = dto.name
        else {
            throw NSError(domain: "CountryListNetworkMapper", code: 1)
        }
        let imageURL = getImageURL(dtoImageURL: dto.imageURL)
        
        return Country(
            code: code,
            name: name,
            imageURL: imageURL
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
