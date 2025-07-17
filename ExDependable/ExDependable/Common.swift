//
//  Common.swift
//  ExDependable
//
//  Created by Kant on 7/17/25.
//

import Foundation

// MARK: - DI와 ServiceLocator 가 공통으로 사용하는 프로토콜 & 클래스 입니다.

protocol AnalyticsService {
    func log(event: String)
}

final class FirebaseAnalyticsService: AnalyticsService {
    func log(event: String) {
        print("🔥 Firebase log: \(event)")
    }
}
