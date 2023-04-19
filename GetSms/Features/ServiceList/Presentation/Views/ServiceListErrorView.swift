//
//  ServiceListErrorView.swift
//  GetSms
//
//  Created by Роман Ломтев on 10.04.2023.
//

import SwiftUI

struct ServiceListErrorView: View {
    
    let vo: ServiceListErrorVO
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                Text(vo.description)
                
                Spacer()
            }
            
            Spacer()
        }
        
    }
}

struct ServiceListErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceListErrorView(
            vo: ServiceListErrorVO(
                description: "Error!"
            )
        )
        .background(Color("DarkBlueColor"))
    }
}
