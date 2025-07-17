//
//  DI.swift
//  ExDependable
//
//  Created by Kant on 7/16/25.
//

import Foundation

final class LoginViewModel {
    private let analyticsService: AnalyticsService
    
    init(analyticsService: AnalyticsService) {
        self.analyticsService = analyticsService
    }
    
    func login() {
        analyticsService.log(event: "User Logged In")
    }
}
