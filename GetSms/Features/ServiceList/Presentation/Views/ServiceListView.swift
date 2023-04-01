//
//  ContentView.swift
//  GetSms
//
//  Created by Роман Ломтев on 19.03.2023.
//

import SwiftUI

struct ServiceListView: View {
    
    // MARK: - External vars
    @EnvironmentObject var viewModel: ServiceListViewModel
    
    @State private var state: ServiceListState = .Idle
    
    var body: some View {
        VStack {
            
            ServiceSearchView(onTextChanged: { inputText in
                viewModel.searchService(inputText: inputText)
            })
            
            ScrollView {
                switch state {
                    
                case .Idle:
                    Spacer()
                    
                case .Loading:
                    ServiceListLoadingView()
                    
                case .Loaded(let vo):
                    ServiceListLoadedView(vo: vo)
                    
                case .Error(let vo):
                    ServiceListErrorView(vo: vo)
                }
            }
            .refreshable {
                viewModel.loadServiceList()
            }
            .onReceive(viewModel.$state) { newState in
                withAnimation {
                    state = newState
                }
            }
        }
        .padding(8)
        .background(Color("DarkBlueColor"))
        .onAppear {
            viewModel.onViewAppear()
        }
    }
}

struct ServiceListLoadedView: View {
    
    let vo: ServiceListVO
    
    var body: some View {
        ForEach(vo.services) { serviceVo in
            ServiceView(vo: serviceVo, pressAction: {})
        }
    }
}

struct ServiceListLoadingView: View {
    
    var body: some View {
        ForEach((1...10), id: \.self) { _ in
            ServicePlaceholderView()
        }
    }
}

struct ServiceListErrorView: View {
    
    let vo: ServiceListErrorVO
    
    var body: some View {
        Text(vo.description)
    }
}
