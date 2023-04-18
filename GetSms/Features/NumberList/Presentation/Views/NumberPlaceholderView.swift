//
//  NumberPlaceholderView.swift
//  GetSms
//
//  Created by Роман Ломтев on 16.04.2023.
//

import SwiftUI

struct NumberPlaceholderView: View {
    
    // MARK: - External vars

    let backgroundColor: Color = Color("YellowColor")
    
    var body: some View {
        HStack(alignment: .center) {
            
            VStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 120, height: 17)
                
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 40, height: 12)
            }
            
            Spacer()
            
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 90, height: 15)
            
            Spacer()
            
            Button(action: {}) {
                Text("ОТМЕНА")
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
            .disabled(true)
            .padding(4)
            .overlay(RoundedRectangle(cornerRadius: 5)
                .stroke(
                    Color("GreenColor"),
                    lineWidth: 1
                )
            )
        }
        .frame(height: 40)
        .padding(16)
        .shimmer(
            tint: .gray.opacity(0.3),
            highlight: .white,
            blur: 5
        )
        .background(Rectangle()
            .fill(.linearGradient(
                colors: [
                    backgroundColor
                        .opacity(0.04),
                    backgroundColor
                        .opacity(0.33),
                    backgroundColor
                        .opacity(0.04)
                ],
                startPoint: .leading,
                endPoint: .trailing
            ))
            .cornerRadius(5)
        )
    }
}

struct NumberPlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            NumberPlaceholderView()
            
            Spacer()
        }
        .padding(1)
        .background(Color("DarkBlueColor"))
        .overlay(RoundedRectangle(cornerRadius: 5)
            .stroke(Color("PinkColor"), lineWidth: 1)
        )
    }
}
