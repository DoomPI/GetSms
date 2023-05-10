//
//  NumberListScreen.swift
//  GetSms
//
//  Created by Роман Ломтев on 16.04.2023.
//

import SwiftUI

struct NumberListTab: View {
    
    @EnvironmentObject var viewModel: NumberListViewModel
    @Binding var errorState: ErrorState
    
    var body: some View {
        switch errorState {
        case .Error(let message):
            Text("Refresh!").onTapGesture {
                viewModel.loadNumberList()
            }
        case .None:
            NumberListView()
                .environmentObject(viewModel)
        }
    }
}
