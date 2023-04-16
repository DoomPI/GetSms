//
//  NumberListLoadingView.swift
//  GetSms
//
//  Created by Роман Ломтев on 16.04.2023.
//

import SwiftUI

struct NumberListLoadingView: View {
    
    @EnvironmentObject var viewModel: NumberListViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach((1...10), id: \.self) { _ in
                    NumberPlaceholderView()
                }
            }
            .refreshable {
                viewModel.loadNumberList()
            }
        }
    }
}

struct NumberListLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        NumberListLoadingView()
            .background(Color("DarkBlueColor"))
    }
}
