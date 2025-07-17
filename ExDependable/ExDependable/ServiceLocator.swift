//
//  ServiceLocator.swift
//  ExDependable
//
//  Created by Kant on 7/17/25.
//

import Foundation

final class ServiceLocator {
    static let shared = ServiceLocator()
    private var services: [String: Any] = [:]
    
    func register<T>(_ service: T, for type: T.Type) {
        services[String(describing: type)] = service
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        guard let service = services[String(describing: type)] as? T else {
            fatalError("❌ Service \(type) not found")
        }
        return service
    }
}
