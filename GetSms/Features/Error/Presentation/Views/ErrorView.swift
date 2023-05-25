//
//  ErrorView.swift
//  GetSms
//
//  Created by Рамиль Зиганшин on 27.04.2023.
//

import SwiftUI

struct ErrorView: View {
    
    private let errorNotificationShowTime: UInt64 = 2_000_000_000
    
    @Binding var errorState: ErrorState
    
    var body: some View {
        VStack {
            switch errorState {
            case .InfError(let message):
                Text(message)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 15)
                    .background(.red)
                    .cornerRadius(15)
                    .padding(.horizontal, 10)
                    .animation(.spring(dampingFraction: 0.5), value: 1)
            case .TempError(let message):
                Text(message)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 15)
                    .background(.red)
                    .cornerRadius(15)
                    .padding(.horizontal, 10)
                    .animation(.spring(dampingFraction: 0.5), value: 1)
                    .task(hideNotification)
            case .None:
                EmptyView()
            }
            Spacer()
        } .padding(.vertical, 15)
            .padding(.horizontal, 5)
    }
    
    @Sendable private func hideNotification() async {
        switch errorState {
        case .TempError(_):
            try? await Task.sleep(nanoseconds: errorNotificationShowTime)
        default:
            return
        }
        errorState = .None
    }
}
