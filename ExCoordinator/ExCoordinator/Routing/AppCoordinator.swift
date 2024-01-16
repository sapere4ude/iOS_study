//
//  AppCoordinator.swift
//  ExCoordinator
//
//  Created by Kant on 1/16/24.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let coordinator = HomeCoordinator(
            navigationController: self.navigationController
        )
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
}
