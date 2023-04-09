//
//  AuthBlockingLoadingView.swift
//  GetSms
//
//  Created by Роман Ломтев on 09.04.2023.
//

import SwiftUI

struct AuthBlockingLoadingView: View {
    var body: some View {
        Color("DarkerBlueColor")
            .overlay {
                ProgressView()
                    .tint(Color("PinkColor"))
            }
    }
}

struct AuthBlockingLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        AuthBlockingLoadingView()
    }
}
