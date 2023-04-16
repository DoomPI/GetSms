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
    @ObservedObject var paymentViewModel = PaymentAssembly.assemble()
    
    @State private var isPaymentBottomsheetPresented = false
    @State private var isSearchViewLoading = false
    
    @Binding var navigationState: NavigationState
 
    var body: some View {
        VStack {
            
            BalanceView()
                .environmentObject(balanceViewModel)

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
        .background(Color("DarkBlueColor"))
        .sheet(isPresented: $isPaymentBottomsheetPresented){
            PaymentView()
                .environmentObject(paymentViewModel)
        }
        .onAppear {
            balanceViewModel.onViewAppear()
            countryListViewModel.onViewAppear()
            serviceListViewModel.onViewAppear()
            paymentViewModel.onViewAppear()
        }
        .onReceive(balanceViewModel.$state) { newState in
            if case .ProceededToPayment = newState {
                paymentViewModel.openPayment()
            }
        }
        .onReceive(countryListViewModel.$state) { newState in
            if case .Loaded(let vo) = newState {
                serviceListViewModel.loadServiceList(countryCode: vo.countries[vo.selectedCountryIndex].code)
            }
        }
        .onReceive(serviceListViewModel.$state) { newState in
            if case .Loading = newState {
                isSearchViewLoading = true
            } else if case .Loaded = newState {
                isSearchViewLoading = false
            }
        }
        .onReceive(paymentViewModel.$state) { newState in
            if case .Opened = newState {
                if !isPaymentBottomsheetPresented {
                    isPaymentBottomsheetPresented = true
                }
            } else if case .Closed = newState {
                if isPaymentBottomsheetPresented {
                    isPaymentBottomsheetPresented = false
                }
                balanceViewModel.reloadBalance()
            }
        }
        .onChange(of: isPaymentBottomsheetPresented) { isPresented in
            if !isPresented {
                paymentViewModel.closePayment()
            }
        }
    }
}
