//
//  NumberListLoadingView.swift
//  GetSms
//
//  Created by Роман Ломтев on 16.04.2023.
//

import SwiftUI

struct NumberListLoadingView: View {
    
    private let numbersCount: Int
    
    init(numbersDisplayedCount: Int?) {
        self.numbersCount = numbersDisplayedCount ?? 10
    }
    
    @EnvironmentObject var viewModel: NumberListViewModel
    
    var body: some View {
        VStack {
            
            ScrollView {
                ForEach((1...numbersCount), id: \.self) { _ in
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
        NumberListLoadingView(numbersDisplayedCount: nil)
            .background(Color("DarkBlueColor"))
    }
}
