//
//  TimHortonsAppApp.swift
//  TimHortonsApp
//
//  Created by Cemar on 2026-05-21.
//

import SwiftUI
import SwiftData

// @main flags this structure as the absolute entry point and initialization root of the application
@main
struct TimHortonsAppApp: App {
    var body: some Scene {
        WindowGroup {
            // SplashView is launched first here to handle the loading screen animation sequence
            SplashView()
        }
        // Injects and initializes the persistent database storage container layer required by SwiftData models
        .modelContainer(for: CoffeeItem.self)
    }
}
