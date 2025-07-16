//
//  ExDependableApp.swift
//  ExDependable
//
//  Created by Kant on 7/16/25.
//

import SwiftUI

@main
struct ExDependableApp: App {

    // 1. Dependency Injection 방식
    init() {
        let analytics = FirebaseAnalyticsService()
        let loginViewModel = LoginViewModel(analyticsService: analytics)
        loginViewModel.login()
    }

    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
