//
//  HomeCoordinator.swift
//  ExCoordinator
//
//  Created by Kant on 1/16/24.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func startAddContact()
}

final class HomeCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = HomeViewController(coordinator: self)
        self.navigationController.viewControllers = [viewController]
    }
}

extension HomeCoordinator: HomeViewControllerDelegate {
    func startAddContact() {
//        let coordinator = AddContactCoordinator(
//            navigationController: self.navigationController,
//            contactRepository: self.contactRepository
//        )
//        coordinator.parentCoordinator = self
//        coordinator.start()
//        self.childCoordinators.append(coordinator)
    }
}

// TODO: DetailCoordinator 마저 만들고, DetailViewController 만들기

final class DetailCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator]
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = HomeViewController(coordinator: self)
        self.navigationController.viewControllers = [viewController]
    }
    
    
}
