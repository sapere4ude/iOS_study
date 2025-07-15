//
//  ExEventPublisherApp.swift
//  ExEventPublisher
//
//  Created by Kant on 7/15/25.
//

import SwiftUI

@main
struct ExEventPublisherApp: App {
    var body: some Scene {
        WindowGroup {
            VStack(spacing: 30) {
                FeedListView()
            }
        }
    }
}
