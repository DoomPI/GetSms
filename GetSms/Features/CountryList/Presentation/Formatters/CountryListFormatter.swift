//
//  CountryListFormatter.swift
//  GetSms
//
//  Created by Роман Ломтев on 01.04.2023.
//

class CountryListFormatter {
    
    private static let defaultSelectedCountryCode = "ru"
    
    func format(model: CountryList) -> CountryListVO {
        let countries = model.countries.map { country in
            format(model: country)
        }
        let selectedCountryIndex = model.selectedCountryIndex
        
        return CountryListVO(
            countries: countries,
            selectedCountryIndex: selectedCountryIndex
        )
    }
    
    private func format(model: Country) -> CountryVO {
        let code = model.code
        let name = model.name
        let imageURL = model.imageURL
        
        return CountryVO(
            code: code,
            name: name,
            imageURL: imageURL
        )
    }
}
