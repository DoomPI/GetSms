//
//  ContentView.swift
//  GetSms
//
//  Created by Роман Ломтев on 19.03.2023.
//

import SwiftUI

struct ServiceListView: View {
    
    @EnvironmentObject var viewModel: ServiceListViewModel
    
    @State private var state: ServiceListState = .Loading
    
    var body: some View {
        VStack {
            switch state {
                
            case .Idle:
                ServiceListLoadingView()
                    .environmentObject(viewModel)
                
            case .Loading:
                ServiceListLoadingView()
                    .environmentObject(viewModel)
                
            case .Loaded(let vo):
                ServiceListLoadedView(vo: vo)
                    .environmentObject(viewModel)
                
            case .Error(let vo):
                ServiceListErrorView(vo: vo)
                
            }
        }
        .onReceive(viewModel.$state) { newState in
            withAnimation {
                state = newState
            }
        }
    }
}
