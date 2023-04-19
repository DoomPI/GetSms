//
//  ServicePlaceholderView.swift
//  GetSms
//
//  Created by Роман Ломтев on 26.03.2023.
//

import SwiftUI

struct ServicePlaceholderView: View {
    
    // MARK: - External vars

    let backgroundColor: Color = Color("GreenColor")
    
    var body: some View {
        HStack(alignment: .center) {
            
            Circle()
                .frame(width: 30, height: 30)
            
            VStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 120, height: 17)
                
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 40, height: 12)
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 30, height: 12)
                }
            }
            
            Spacer()
            
            Button(action: {}) {
                Text("ПОЛУЧИТЬ")
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

struct ServicePlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ServicePlaceholderView()
            
            Spacer()
        }
        .padding(1)
        .background(Color("DarkBlueColor"))
        .overlay(RoundedRectangle(cornerRadius: 5)
            .stroke(Color("PinkColor"), lineWidth: 1)
        )
    }
}
