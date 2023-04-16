//
//  NumberListErrorView.swift
//  GetSms
//
//  Created by Роман Ломтев on 16.04.2023.
//

import SwiftUI

struct NumberListErrorView: View {
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                Text("Error!")
                
                Spacer()
            }
            
            Spacer()
        }
        
    }
}

struct NumberListErrorView_Previews: PreviewProvider {
    static var previews: some View {
        NumberListErrorView()
            .background(Color("DarkBlueColor"))
    }
}
