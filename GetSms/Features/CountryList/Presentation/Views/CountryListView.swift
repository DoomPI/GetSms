//
//  CountryListView.swift
//  GetSms
//
//  Created by Роман Ломтев on 01.04.2023.
//

import SwiftUI

struct CountryListView: View {
    
    @EnvironmentObject var viewModel: CountryListViewModel
    
    @State private var state: CountryListState = .Idle
    
    var body: some View {
        
        VStack {
            switch state {
                
            case .Idle:
                Text("Idle")
                
            case .Loading:
                CountryListLoadingView()
                
            case .Loaded(let vo):
                CountryListLoadedView(
                    vo: vo,
                    onCountrySelected: { countryCode in
                        viewModel.onCountrySelected(countryCode: countryCode)
                    }
                )
                
            case .Error(let vo):
                CountryListErrorView(vo: vo)
                
            }
        }
        .onReceive(viewModel.$state) { newState in
            withAnimation {
                state = newState
            }
        }
        .onAppear {
            viewModel.onViewAppear()
        }
    }
}

struct CountryListLoadingView: View {
    
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

struct CountryListErrorView: View {
    
    let vo: CountryListErrorVO
    
    var body: some View {
        Text(vo.description)
    }
}
