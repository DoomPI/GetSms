//
//  ContentView.swift
//  GetSms
//
//  Created by Роман Ломтев on 19.03.2023.
//

import SwiftUI

struct ServiceListScreen: View {
    
    // MARK: - External vars
    @ObservedObject var viewModel: ServiceListViewModel
    
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
                    ServiceListPlaceholderView()
                    
                case .Loaded(let vo):
                    ServiceListView(vo: vo)
                    
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

struct ServiceListView: View {
    
    let vo: ServiceListVO
    
    var body: some View {
        ForEach(vo.data) { serviceVo in
            ServiceView(vo: serviceVo, pressAction: {})
        }
    }
}

struct ServiceListPlaceholderView: View {
    
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
