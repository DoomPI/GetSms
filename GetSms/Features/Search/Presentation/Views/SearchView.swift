//
//  SearchView.swift
//  GetSms
//
//  Created by Роман Ломтев on 15.04.2023.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var isLoading: Bool
    @State private var inputText: String = ""
    
    let hint: String
    let onTextChanged: (String) -> Void
    
    var body: some View {
        if isLoading {
            SearchPlaceholderView(hint: hint)
        } else {
            HStack(alignment: .center, spacing: 12) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 24))
                    .foregroundColor(Color("PinkColor"))
                
                SearchTextField(
                    hint: hint,
                    inputText: $inputText
                )
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
}

struct SearchTextField: View {
    
    let hint: String
    
    @Binding
    var inputText: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            if (inputText.isEmpty) {
                Text(hint)
                    .fontWeight(.bold)
                    .foregroundColor(Color("GrayColor"))
            }
            
            TextField("", text: $inputText)
                .foregroundColor(.white)
        }
    }
}

struct ServiceSearchView_Previews: PreviewProvider {
    
    @State static var isLoading = false
    
    static var previews: some View {
        SearchView(
            isLoading: $isLoading,
            hint: "Поиск сервиса",
            onTextChanged: {_ in }
        )
    }
}

