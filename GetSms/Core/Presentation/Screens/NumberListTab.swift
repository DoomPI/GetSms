//
//  NumberListScreen.swift
//  GetSms
//
//  Created by Роман Ломтев on 16.04.2023.
//

import SwiftUI

struct NumberListTab: View {
    
    @ObservedObject var viewModel = NumberListAssembly.assemble()
    
    var body: some View {
        NumberListView()
            .environmentObject(viewModel)
            .onAppear {
                viewModel.onViewAppear()
            }
    }
}
