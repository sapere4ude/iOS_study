//
//  Coordinator.swift
//  ExCoordinator
//
//  Created by Kant on 1/16/24.
//

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}
