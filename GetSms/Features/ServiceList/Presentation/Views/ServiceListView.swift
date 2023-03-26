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
    
    // MARK: - Init
    init(viewModel: ServiceListViewModel) {
        self.viewModel = viewModel
        viewModel.subscribeToIntents()
    }

    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            
            Group { () -> AnyView in
                switch viewModel.state {
                    
                case .Idle:
                    return AnyView(Text("Idle"))
                    
                case.Loading:
                    return AnyView(Text("Loading"))
                    
                case .Loaded(let vo):
                    return AnyView(Text("Loaded " + vo.data[0].name))
                    
                case .Error(let vo):
                    return AnyView(Text("Error"))
                }
            }
            
            List {
                
            }
            
        }
        .padding()
    }
}
