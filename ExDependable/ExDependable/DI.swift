//
//  DI.swift
//  ExDependable
//
//  Created by Kant on 7/16/25.
//

import Foundation

// 공통
protocol AnalyticsService {
    func log(event: String)
}

final class FirebaseAnalyticsService: AnalyticsService {
    func log(event: String) {
        print("🔥 Firebase log: \(event)")
    }
}

/* --------------------------------------------------------- */

// 방법1
final class LoginViewModel {
    private let analyticsService: AnalyticsService
    
    init(analyticsService: AnalyticsService) {
        self.analyticsService = analyticsService
    }
    
    func login() {
        analyticsService.log(event: "User Logged In")
    }
}

final class ServiceLocator {
    static let shared = ServiceLocator()
    private var services: [String: Any] = [:]
    
    func register<T>(_ serive: T, for type: T.Type) {
        services[String(describing: type)] = service
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        guard let service = services[String(describing: type)] as? T? else {
            fatalError("❌ Service \(type) not found")
        }
        return service
    }
}
