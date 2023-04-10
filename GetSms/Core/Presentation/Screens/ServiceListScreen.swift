//
//  ServiceListScreen.swift
//  GetSms
//
//  Created by Роман Ломтев on 01.04.2023.
//
 
import SwiftUI
 
struct ServiceListScreen: View {
 
    @ObservedObject var balanceViewModel = BalanceAssembly.assemble()
    @ObservedObject var countryListViewModel = CountryListAssembly.assemble()
    @ObservedObject var serviceListViewModel = ServiceListAssembly.assemble()
    
    @Binding var navigationState: NavigationState
 
    var body: some View {
        VStack {
            
            BalanceView()
                .environmentObject(balanceViewModel)

            CountryListView()
                .environmentObject(countryListViewModel)

            ServiceListView()
                .environmentObject(serviceListViewModel)
        }
        .padding(8)
        .background(Color("DarkBlueColor"))
        .onReceive(balanceViewModel.$state) { newState in
            if case .ProceededToPayment = newState {
                navigationState = .Payment
            }
        }
        .onReceive(countryListViewModel.$state) { newState in
            if case .Loaded(let vo) = newState {
                serviceListViewModel.loadServiceList(countryCode: vo.countries[vo.selectedCountryIndex].code)
            }
        }
    }
}
