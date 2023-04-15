//
//  WebNavigationView.swift
//  GetSms
//
//  Created by Роман Ломтев on 02.04.2023.
//

import SwiftUI

struct WebNavigationView: View {
    
    let goForwardAction: () -> Void
    let goBackwardAction: () -> Void
    let reloadAction: () -> Void
    
    var body: some View {
        HStack {
            Button(action: goBackwardAction) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 30, weight: .regular))
                    .foregroundColor(Color("PinkColor"))
                    .imageScale(.medium)
            }
            Button(action: goForwardAction) {
                Image(systemName: "chevron.right")
                    .font(.system(size: 30, weight: .regular))
                    .foregroundColor(Color("PinkColor"))
                    .imageScale(.medium)
            }
            Spacer()
            Button(action: reloadAction) {
                Image(systemName: "arrow.clockwise")
                    .font(.system(size: 30, weight: .regular))
                    .foregroundColor(Color("PinkColor"))
                    .imageScale(.medium)
            }
        }
        .frame(height: 40)
        .padding(8)
    }
}

struct WebNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        WebNavigationView(
            goForwardAction: {},
            goBackwardAction: {},
            reloadAction: {}
        )
    }
}
