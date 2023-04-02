//
//  ServiceSearchPlaceholderView.swift
//  GetSms
//
//  Created by Роман Ломтев on 02.04.2023.
//

import SwiftUI

struct ServiceSearchPlaceholderView: View {
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 24))
                .foregroundColor(Color("PinkColor"))
            
            Text("Поиск сервиса")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundColor(Color("GrayColor"))
            
            Spacer()
        }
        .frame(height: 30)
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

struct ServiceSearchPlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceSearchPlaceholderView()
    }
}
