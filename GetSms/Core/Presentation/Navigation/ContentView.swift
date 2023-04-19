//
//  ContentView.swift
//  GetSms
//
//  Created by Роман Ломтев on 09.04.2023.
//

import Foundation
import SwiftUI

struct ContentView: View {
    
    @State private var navigationState: NavigationState = .Auth
    
    var body: some View {
        ZStack {
            
            switch navigationState {
                
            case .Auth:
                AuthScreen(navigationState: $navigationState)
                
            case .Main:
                MainScreen(navigationState: $navigationState)

            }
        }
    }
}

enum NavigationState: Hashable {
    
    case Auth
    
    case Main
}
