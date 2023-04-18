//
//  ServiceListScreen.swift
//  GetSms
//
//  Created by Роман Ломтев on 01.04.2023.
//
 
import SwiftUI
 
struct ServiceListTab: View {
 
    @EnvironmentObject var countryListViewModel: CountryListViewModel
    @EnvironmentObject var serviceListViewModel: ServiceListViewModel
    
    @State private var isSearchViewLoading = false
 
    var body: some View {
        VStack {

            CountryListView()
                .environmentObject(countryListViewModel)
            
            SearchView(
                isLoading: $isSearchViewLoading,
                hint: "Поиск Сервиса"
            ) { searchText in
                serviceListViewModel.searchService(inputText: searchText)
            }

            ServiceListView()
                .environmentObject(serviceListViewModel)
        }
        .padding(8)
        .onReceive(countryListViewModel.$state) { newState in
            if case .Loaded(let vo) = newState {
                serviceListViewModel.loadServiceList(countryCode: vo.countries[vo.selectedCountryIndex].code)
            }
        }
        .onReceive(serviceListViewModel.$state) { newState in
            switch newState {
                
            case .Loading, .BlockingLoading:
                isSearchViewLoading = true
                
            case .Loaded:
                isSearchViewLoading = false
                
            default:
                break
            }
        }
    }
}
