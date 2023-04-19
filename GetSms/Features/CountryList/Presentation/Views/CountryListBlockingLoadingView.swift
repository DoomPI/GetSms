//
//  CountryListBlockingLoadingView.swift
//  GetSms
//
//  Created by Роман Ломтев on 18.04.2023.
//

import SwiftUI

struct CountryListBlockingLoadingView: View {
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            
            Image(systemName: "chevron.down")
                .font(.system(size: 24))
                .foregroundColor(Color("PinkColor"))
            
            CountryPlaceholderView()
            
            Spacer()
        }
        .padding(12)
        .overlay(RoundedRectangle(cornerRadius: 5)
            .stroke(Color("PinkColor"), lineWidth: 2)
        )
        .shimmer(
            tint: .gray.opacity(0.3),
            highlight: .white,
            blur: 5
        )
    }
}

struct CountryListBlockingLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        CountryListLoadingView()
            .background(Color("DarkBlueColor"))
    }
}

