//
//  NumberListScreen.swift
//  GetSms
//
//  Created by Роман Ломтев on 16.04.2023.
//

import SwiftUI

struct NumberListTab: View {
    
    @EnvironmentObject var viewModel: NumberListViewModel
    
    var body: some View {
        NumberListView()
            .environmentObject(viewModel)
            .onAppear {
                viewModel.onViewAppear()
            }
    }
}
