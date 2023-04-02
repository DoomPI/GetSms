//
//  AuthView.swift
//  GetSms
//
//  Created by Роман Ломтев on 02.04.2023.
//

import SwiftUI

struct AuthView: View {
    
    var body: some View {
        WebView(url: "https://vak-sms.com/accounts/login/")
            .ignoresSafeArea(.all)
    }
}
