//
//  CountryListLoadedView.swift
//  GetSms
//
//  Created by Роман Ломтев on 10.04.2023.
//

import SwiftUI

struct CountryListLoadedView: View {
    
    let vo: CountryListVO
    let onCountrySelected: (String) -> Void
    
    var body: some View {
        CountryListDropdownView(
            vo: vo,
            onSelected: onCountrySelected
        )
    }
}

struct CountryListLoadedView_Previews: PreviewProvider {
    static var previews: some View {
        CountryListLoadedView(
            vo: CountryListVO(
                countries: [
                    CountryVO(
                        code: "ru",
                        name: "Russia",
                        imageURL: URL(
                            string: "https://vak-sms.com/static/country/ru.png"
                        )
                    )
                ],
                selectedCountryIndex: 0
            ),
            onCountrySelected: { _ in }
        )
        .background(Color("DarkBlueColor"))
    }
}
