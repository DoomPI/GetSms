//
//  NumberListErrorView.swift
//  GetSms
//
//  Created by Роман Ломтев on 16.04.2023.
//

import SwiftUI

struct NumberListErrorView: View {
    
    let errorVo: NumberDataListErrorVO
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                Text(errorVo.description)
                
                Spacer()
            }
            
            Spacer()
        }
        
    }
}

struct NumberListErrorView_Previews: PreviewProvider {
    static var previews: some View {
        NumberListErrorView(errorVo: NumberDataListErrorVO(description: "Error!", isTemp: false))
            .background(Color("DarkBlueColor"))
    }
}
