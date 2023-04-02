//
//  ServiceSearchView.swift
//  GetSms
//
//  Created by Роман Ломтев on 31.03.2023.
//

import SwiftUI

struct ServiceSearchView: View {
    
    let onTextChanged: (String) -> Void

    @State
    private var inputText: String = ""
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 24))
                .foregroundColor(Color("PinkColor"))
            
            SearchTextField(inputText: $inputText)
                .font(.system(size: 20))
        }
        .frame(height: 30)
        .padding(12)
        .overlay(RoundedRectangle(cornerRadius: 5)
            .stroke(Color("PinkColor"), lineWidth: 2)
        )
        .onChange(of: inputText) { newInputText in
            onTextChanged(newInputText)
        }
    }
}

struct SearchTextField: View {
    
    @Binding
    var inputText: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            if (inputText.isEmpty) {
                Text("Поиск сервиса")
                    .fontWeight(.bold)
                    .foregroundColor(Color("GrayColor"))
            }
            
            TextField("", text: $inputText)
                .foregroundColor(.white)
        }
    }
}

struct ServiceSearchView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceSearchView(onTextChanged: {_ in })
    }
}
