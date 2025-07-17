//
//  ExDependableApp.swift
//  ExDependable
//
//  Created by Kant on 7/16/25.
//

import SwiftUI

@main
struct ExDependableApp: App {

    init() {
        // 1. Dependency Injection 방식
        let analytics = FirebaseAnalyticsService()
        let loginViewModel = LoginViewModel(analyticsService: analytics)
        loginViewModel.login()
        
        // 2. Service Locator 방식 (= pull 방식)
        ServiceLocator.shared.register(FirebaseAnalyticsService(), for: AnalyticsService.self)
        let service = ServiceLocator.shared.resolve(AnalyticsService.self)
        service.log(event: "User Logged In")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
