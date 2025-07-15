//
//  EventPublisher.swift
//  ExEventPublisher
//
//  Created by Kant on 7/15/25.
//

import Combine

// EventPublisher: 이벤트 전송과 구독을 안전하게 감싸는 래퍼
final class EventPublisher<Output> {
    private let subject = PassthroughSubject<Output, Never>()
    private let logger: (Output) -> Void
    
    init(logger: @escaping (Output) -> Void = { _ in }) {
        self.logger = logger
    }
    
    func send(_ value: Output) {
        logger(value)
        subject.send(value)
    }
    
    func publisher() -> AnyPublisher<Output, Never> {
        subject.eraseToAnyPublisher()
    }
}
