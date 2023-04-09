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
        VStack {
            Divider()
            HStack(spacing: 10) {
                Divider()
                Button(action: goBackwardAction) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 30, weight: .regular))
                        .foregroundColor(Color("PinkColor"))
                        .imageScale(.medium)
                }
                Divider()
                Button(action: goForwardAction) {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 30, weight: .regular))
                        .foregroundColor(Color("PinkColor"))
                        .imageScale(.medium)
                }
                Divider()
                Spacer()
                Divider()
                Button(action: reloadAction) {
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 30, weight: .regular))
                        .foregroundColor(Color("PinkColor"))
                        .imageScale(.medium)
                }
                Divider()
            }
            .frame(height: 50)
            Divider()
        }
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
