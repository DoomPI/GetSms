//
//  ServiceListErrorView.swift
//  GetSms
//
//  Created by Роман Ломтев on 10.04.2023.
//

import SwiftUI

struct ServiceListErrorView: View {
    
    @EnvironmentObject var viewModel: ServiceListViewModel
    let vo: ServiceListErrorVO
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                Text("Refresh").onTapGesture {
                    viewModel.loadServiceList()
                }
                
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
