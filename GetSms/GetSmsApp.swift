//
//  GetSmsApp.swift
//  GetSms
//
//  Created by Роман Ломтев on 19.03.2023.
//

import SwiftUI

@main
struct GetSmsApp: App {
    var body: some Scene {
        WindowGroup {
            ServiceListScreen(serviceListViewModel: ServiceListAssembly.assemble())
        }
    }
}
