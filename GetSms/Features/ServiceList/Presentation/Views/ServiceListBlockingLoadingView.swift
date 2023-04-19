//
//  ServiceListBlockingLoadingView.swift
//  GetSms
//
//  Created by Роман Ломтев on 18.04.2023.
//

import SwiftUI

struct ServiceListBlockingLoadingView: View {
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach((1...10), id: \.self) { _ in
                    ServicePlaceholderView()
                }
            }
        }
    }
}
struct ServiceListBlockingLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceListBlockingLoadingView()
            .background(Color("DarkBlueColor"))
    }
}
