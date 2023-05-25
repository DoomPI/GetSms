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
    var updateFunc: () -> Void
    
    var body: some View {
        switch errorState {
        case .InfError(_):
            Text("Tap to refresh").onTapGesture {
                updateFunc()
            }
        case .TempError(_):
            Text("Tap to refresh").onTapGesture {
                updateFunc()
            }
        case .None:
            NumberListView()
                .environmentObject(viewModel)
        }
    }
}
