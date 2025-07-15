//
//  GlobalEventBridge.swift
//  ExEventPublisher
//
//  Created by Kant on 7/15/25.
//

import Combine

final class GlobalEventBridge {
    static let shared = GlobalEventBridge()
    private init() {}

    private let likeEvent = EventPublisher<LikeEvent> {
        print("👍 Like 이벤트 발생: \($0)")
    }

    var likePublisher: AnyPublisher<LikeEvent, Never> {
        likeEvent.publisher()
    }

    func sendLikeEvent(_ event: LikeEvent) {
        likeEvent.send(event)
    }
}
