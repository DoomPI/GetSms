//
//  CountryListDropListView.swift
//  GetSms
//
//  Created by Роман Ломтев on 02.04.2023.
//

import SwiftUI

struct CountryListDropdownView: View {
    let vo: CountryListVO
    let onSelected: (String) -> Void
    
    @State private var isExpanded = false
    
    var body: some View {
        
        VStack {
            
            CountryListDropListHeaderView(
                vo: vo.countries[vo.selectedCountryIndex],
                onClick: toggleExpand
            )
            
            if (isExpanded) {
                ScrollView {
                    VStack {
                        ForEach(vo.countries.indices, id: \.self) { index in
                            Button(action: {
                                onSelected(vo.countries[index].code)
                                toggleExpand()
                            }) {
                                HStack {
                                    CountryView(vo: vo.countries[index])
                                    
                                    Spacer()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func toggleExpand() {
        withAnimation(.default) {
            isExpanded.toggle()
        }
    }
}

struct CountryListDropListHeaderView: View {
    
    let vo: CountryVO
    let onClick: () -> Void
    
    var body: some View {
        Button(action: onClick) {
            HStack(alignment: .center, spacing: 12) {
                
                
                Image(systemName: "chevron.down")
                    .font(.system(size: 24))
                    .foregroundColor(Color("PinkColor"))
                
                CountryView(vo: vo)
                
                Spacer()
            }
        }
        .padding(12)
        .overlay(RoundedRectangle(cornerRadius: 5)
            .stroke(Color("PinkColor"), lineWidth: 2)
        )
    }
}
