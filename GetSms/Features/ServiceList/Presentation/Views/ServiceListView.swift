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
    
    var body: some View {
        VStack {
            
            List {
                switch viewModel.state {
                    
                case .Idle:
                    Text("Idle")
                    
                case.Loading:
                    ForEach((1...10), id: \.self) { _ in
                        ServicePlaceholderView()
                            .listRowBackground(Color.white.opacity(0))
                            .listRowInsets(EdgeInsets(
                                top: 4,
                                leading: 0,
                                bottom: 4,
                                trailing: 0
                            ))
                            .listRowSeparator(.hidden)
                    }
                    
                case .Loaded(let vo):
                    
                    ForEach(vo.data) { serviceVo in
                        ServiceView(vo: serviceVo, pressAction: {})
                            .listRowBackground(Color.white.opacity(0))
                            .listRowInsets(EdgeInsets(
                                top: 4,
                                leading: 0,
                                bottom: 4,
                                trailing: 0
                            ))
                            .listRowSeparator(.hidden)
                    }
                    
                case .Error(let vo):
                    Text("Error")
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .refreshable {
                viewModel.loadServiceList()
            }
        }
        .padding(8)
        .background(Color("DarkBlueColor"))
        .onAppear {
            viewModel.onViewAppear()
        }
    }
}
