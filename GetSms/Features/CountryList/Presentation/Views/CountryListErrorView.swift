//
//  CountryListErrorView.swift
//  GetSms
//
//  Created by Роман Ломтев on 10.04.2023.
//

import SwiftUI

struct CountryListErrorView: View {
    
    let vo: CountryListErrorVO
    
    var body: some View {
        Text(vo.description)
    }
}


struct CountryListErrorView_Previews: PreviewProvider {
    static var previews: some View {
        CountryListErrorView(
            vo: CountryListErrorVO(
                description: "Error!"
            )
        )
        .background(Color("DarkBlueColor"))
    }
}
