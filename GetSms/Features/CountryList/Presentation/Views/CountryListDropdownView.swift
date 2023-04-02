//
//  CountryListDropListView.swift
//  GetSms
//
//  Created by Роман Ломтев on 02.04.2023.
//

import SwiftUI

struct CountryListDropdownView: View {
    let vo: CountryListVO
    
    @State private var isExpanded = false
    @State private var selectedServiceIndex = 0
    
    var body: some View {
        
        VStack {
            
            CountryListDropListHeaderView(
                vo: vo.countries[selectedServiceIndex],
                onClick: toggleExpand
            )
            
            if (isExpanded) {
                ScrollView {
                    LazyVStack {
                        ForEach(vo.countries.indices, id: \.self) { index in
                            Button(action: {
                                selectedServiceIndex = index
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
                .background(Color("DarkBlueColor"))
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
