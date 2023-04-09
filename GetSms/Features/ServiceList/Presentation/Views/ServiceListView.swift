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
        .onAppear {
            viewModel.onViewAppear()
        }
    }
}

struct ServiceListLoadedView: View {
    
    @EnvironmentObject var viewModel: ServiceListViewModel
    
    let vo: ServiceListVO
    
    var body: some View {
        VStack {
            ServiceSearchView(onTextChanged: { inputText in
                viewModel.searchService(inputText: inputText)
            })
            
            ScrollView {
                ForEach(vo.services.indices, id: \.self) { index in
                    ServiceView(vo: vo.services[index], pressAction: {})
                }
            }
            .refreshable {
                viewModel.loadServiceList()
            }
        }
    }
}

struct ServiceListLoadingView: View {
    
    @EnvironmentObject var viewModel: ServiceListViewModel
    
    var body: some View {
        VStack {
            ServiceSearchPlaceholderView()
            
            ScrollView {
                ForEach((1...10), id: \.self) { _ in
                    ServicePlaceholderView()
                }
            }
            .refreshable {
                viewModel.loadServiceList()
            }
        }
    }
}

struct ServiceListErrorView: View {
    
    let vo: ServiceListErrorVO
    
    var body: some View {
        Text(vo.description)
    }
}
