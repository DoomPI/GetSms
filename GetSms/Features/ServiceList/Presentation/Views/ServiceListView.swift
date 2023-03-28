//
//  ContentView.swift
//  GetSms
//
//  Created by Роман Ломтев on 19.03.2023.
//

import SwiftUI

struct ServiceListView: View {
    
    // MARK: - External vars
    @ObservedObject var viewModel: ServiceListViewModel
    
    @State var state: ServiceListState = .Idle
    
    var body: some View {
        VStack {
            
            ScrollView {
                switch state {
                    
                case .Idle:
                    Text("Idle")
                    
                case .Loading:
                    ForEach((1...10), id: \.self) { _ in
                        ServicePlaceholderView()
                    }
                    
                case .Loaded(let vo):
                    ForEach(vo.data) { serviceVo in
                        ServiceView(vo: serviceVo, pressAction: {})
                    }
                    
                case .Error:
                    Text("Error")
                }
            }
            .refreshable {
                viewModel.loadServiceList()
            }
            .onReceive(viewModel.$state) { newState in
                state = newState
            }
        }
        .padding(8)
        .background(Color("DarkBlueColor"))
        .onAppear {
            viewModel.onViewAppear()
        }
    }
}
