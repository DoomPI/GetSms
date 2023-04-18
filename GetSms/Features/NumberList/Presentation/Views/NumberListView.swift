//
//  NumberListView.swift
//  GetSms
//
//  Created by Роман Ломтев on 16.04.2023.
//

import SwiftUI

struct NumberListView: View {
    
    @EnvironmentObject var viewModel: NumberListViewModel
    
    @State private var state: NumberListState = .Loading
    
    var body: some View {
        VStack {
            switch state {
                
            case .Loading:
                NumberListLoadingView()
                    .environmentObject(viewModel)
                
            case .Loaded(let vo):
                NumberListLoadedView(vo: vo)
                    .environmentObject(viewModel)
                
            case .Error(let vo):
                NumberListErrorView(errorVo: vo)
            }
        }
        .onReceive(viewModel.$state) { newState in
            withAnimation {
                state = newState
            }
        }
    }
}
