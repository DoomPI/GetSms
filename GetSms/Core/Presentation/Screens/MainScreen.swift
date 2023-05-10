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
    @State private var selectedTab: TabNavigationState = .ServiceList
    @State private var errorState: ErrorState = .None
    @State private var errorActiveNumbersState: ErrorState = .None
    @State private var errorStateArr: [ErrorState] = [.None, .None]
    
    @Binding var navigationState: NavigationState
 
    var body: some View {
        VStack {
            BalanceView()
                .environmentObject(balanceViewModel)

                TabView(selection: $selectedTab) {
                    ServiceListTab(errorState: $errorState, updateFunc: updateAll)
                        .tag(TabNavigationState.ServiceList)
                        .environmentObject(countryListViewModel)
                        .environmentObject(serviceListViewModel)
                    NumberListTab(errorState: $errorActiveNumbersState, updateFunc: updateAll)
                        .tag(TabNavigationState.NumberList)
                        .environmentObject(numberListViewModel)
                }
                .tabViewStyle(.page)
        }.overlay(content: {
            ErrorView(errorState: $errorState)
        }).overlay(content: {
            ErrorView(errorState: $errorActiveNumbersState)
        })
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
        .onReceive(balanceViewModel.$routeState) { newState in
            switch newState {
                
            case .PaymentRouting:
                paymentViewModel.openPayment()
                
            case .AuthRouting:
                navigationState = .Auth
                
            default:
                break
            }
        }
        .onReceive(serviceListViewModel.$routeState) { newState in
            switch newState {
                
            case .NumberListInitRouting:
                withAnimation {
                    selectedTab = .NumberList
                }                
                numberListViewModel.setLoading()
                
            case .NumberListFinishRouting:
                numberListViewModel.loadNumberList()
                balanceViewModel.reloadBalance()
                
            default:
                break
            }
        }
        .onReceive(serviceListViewModel.$state) { newState in
            switch newState {
            case .Error(vo: let error):
                errorStateArr[0] = .Error(message: error.description)
            default:
                errorStateArr[0] = .None
            }
            if let dataEr = errorStateArr.first(where: {if case .None = $0 {return false} else {return true}}){
                errorState = dataEr
            } else {
                errorState = .None
            }
        }
        .onReceive(numberListViewModel.$state) { newState in
            switch newState {
            case .Error(vo: let error):
                errorActiveNumbersState = .Error(message: error.description)
            default:
                errorActiveNumbersState = .None
            }
        }
        .onReceive(countryListViewModel.$state) { newState in
            switch newState {
            case .Error(vo: let error):
                errorStateArr[1] = .Error(message: error.description)
            default:
                errorStateArr[1] = .None
            }
            if let dataEr = errorStateArr.first(where: {if case .None = $0 {return false} else {return true}}){
                errorState = dataEr
            } else {
                errorState = .None
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
    
    private func updateAll(){
        if case .Error(_) = errorState {
            serviceListViewModel.loadServiceList()
            countryListViewModel.loadCountryList()
        }
        if case .Error(_) = errorActiveNumbersState {
            numberListViewModel.loadNumberList()
        }
        balanceViewModel.reloadBalance()
    }
}

private enum TabNavigationState {
    
    case ServiceList
    
    case NumberList
}

