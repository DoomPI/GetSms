//
//  MainScreen.swift
//  GetSms
//
//  Created by Роман Ломтев on 16.04.2023.
//

import SwiftUI

struct MainScreen: View {
 
    @ObservedObject var balanceViewModel = BalanceAssembly.assemble()
    @ObservedObject var countryListViewModel = CountryListAssembly.assemble()
    @ObservedObject var serviceListViewModel = ServiceListAssembly.assemble()
    @ObservedObject var paymentViewModel = PaymentAssembly.assemble()
    @ObservedObject var numberListViewModel = NumberListAssembly.assemble()
    
    @State private var isPaymentBottomsheetPresented = false
    @State private var isSearchViewLoading = false
    
    @Binding var navigationState: NavigationState
 
    var body: some View {
        VStack {
            
            BalanceView()
                .environmentObject(balanceViewModel)
            
            TabView {
                ServiceListTab()
                    .environmentObject(countryListViewModel)
                    .environmentObject(serviceListViewModel)
                
                NumberListTab()
                    .environmentObject(numberListViewModel)

            }
            .tabViewStyle(.page)
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
            numberListViewModel.onViewAppear()
        }
        .onReceive(balanceViewModel.$state) { newState in
            if case .ProceededToPayment = newState {
                paymentViewModel.openPayment()
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

