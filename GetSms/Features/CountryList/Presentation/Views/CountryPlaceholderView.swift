//
//  CountryPlaceholderView.swift
//  GetSms
//
//  Created by Роман Ломтев on 02.04.2023.
//

import SwiftUI

struct CountryPlaceholderView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            
            RoundedRectangle(cornerRadius: 4)
                .frame(width: 32, height: 24)
            
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 90, height: 24)
        }
        .frame(height: 24)
    }
}

struct CountryPlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        CountryPlaceholderView()
    }
}
