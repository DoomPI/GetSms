//
//  CountryListFormatter.swift
//  GetSms
//
//  Created by Роман Ломтев on 01.04.2023.
//

class CountryListFormatter {
    
    func format(model: CountryList) -> CountryListVO {
        let countries = model.countries.map { country in
            format(model: country)
        }
        
        return CountryListVO(countries: countries)
    }
    
    private func format(model: Country) -> CountryVO {
        let name = model.name
        let imageURL = model.imageURL
        
        return CountryVO(
            name: name,
            imageURL: imageURL
        )
    }
}
