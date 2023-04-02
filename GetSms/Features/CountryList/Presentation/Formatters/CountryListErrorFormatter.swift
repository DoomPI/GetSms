//
//  CountryListErrorFormatter.swift
//  GetSms
//
//  Created by Роман Ломтев on 01.04.2023.
//

class CountryListErrorFormatter {
    
    func format(error: Error) -> CountryListErrorVO {
        return CountryListErrorVO(
            description: error.localizedDescription
        )
    }
}
