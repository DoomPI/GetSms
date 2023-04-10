//
//  BalanceImage.swift
//  GetSms
//
//  Created by Роман Ломтев on 10.04.2023.
//

import SwiftUI

struct BalanceImage: View {
    
    var body: some View {
        Circle()
            .strokeBorder(
                Color("LightBlueColor"),
                lineWidth: 1
            )
            .background(Circle().foregroundColor(
                Color("BlueColor"))
            )
            .overlay {
                Image("BalanceImage")
            }
            .frame(width: 40, height: 40)
    }
}

struct BalanceImage_Previews: PreviewProvider {
    
    static var previews: some View {
        BalanceImage()
    }
}
