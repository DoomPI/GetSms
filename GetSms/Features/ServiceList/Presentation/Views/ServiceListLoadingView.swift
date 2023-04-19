//
//  ServiceListLoadingView.swift
//  GetSms
//
//  Created by Роман Ломтев on 10.04.2023.
//

import SwiftUI

struct ServiceListLoadingView: View {
    
    @EnvironmentObject var viewModel: ServiceListViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach((1...10), id: \.self) { _ in
                    ServicePlaceholderView()
                }
            }
            .refreshable {
                viewModel.loadServiceList()
            }
        }
    }
}
struct ServiceListLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceListLoadingView()
            .background(Color("DarkBlueColor"))
    }
}
