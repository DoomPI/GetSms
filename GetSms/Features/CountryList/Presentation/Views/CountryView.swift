//
//  CountryView.swift
//  GetSms
//
//  Created by Роман Ломтев on 02.04.2023.
//

import SwiftUI

struct CountryView: View {
    
    let vo: CountryVO
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            
            CountryImage(url: vo.imageURL)
            
            Text(vo.name)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .frame(height: 24)
    }
}

struct CountryImage: View {
    
    let url: URL?
    
    var body: some View {
        if url != nil {
            AsyncImage(url: url) { image in
                image
            } placeholder: {
                Image("ServiceNoImage")
            }
            
        } else {
            Image("ServiceNoImage")
        }
    }
}

struct CountryView_Previews: PreviewProvider {
    static var previews: some View {
        CountryView(
            vo: CountryVO(
                name: "Russia",
                imageURL: URL(string: "https://vak-sms.com/static/country/ru.png")
            )
        )
    }
}
