//
//  ServiceListScreen.swift
//  GetSms
//
//  Created by Роман Ломтев on 01.04.2023.
//
 
import SwiftUI
 
struct ServiceListScreen: View {
 
    @ObservedObject var countryListViewModel: CountryListViewModel
    @ObservedObject var serviceListViewModel: ServiceListViewModel
 
    var body: some View {
        VStack {

            CountryListView()
                .environmentObject(countryListViewModel)

            ServiceListView()
                .environmentObject(serviceListViewModel)
        }
        .padding(8)
        .background(Color("DarkBlueColor"))
        .onReceive(countryListViewModel.$state) { newState in
            if case .Loaded(let vo) = newState{
                serviceListViewModel.loadServiceList(countryCode: vo.countries[vo.selectedCountryIndex].code)
            }
        }
    }
}
