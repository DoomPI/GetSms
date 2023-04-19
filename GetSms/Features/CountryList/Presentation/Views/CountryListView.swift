//
//  CountryListView.swift
//  GetSms
//
//  Created by Роман Ломтев on 01.04.2023.
//

import SwiftUI

struct CountryListView: View {
    
    @EnvironmentObject var viewModel: CountryListViewModel
    
    @State private var state: CountryListState = .Loading
    
    var body: some View {
        
        VStack {
            switch state {
                
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
                
            case .BlockingLoading:
                CountryListBlockingLoadingView()
                
            }
        }
        .onReceive(viewModel.$state) { newState in
            withAnimation {
                state = newState
            }
        }
    }
}
