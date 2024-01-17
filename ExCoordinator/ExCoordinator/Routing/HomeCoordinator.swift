//
//  HomeCoordinator.swift
//  ExCoordinator
//
//  Created by Kant on 1/16/24.
//

import UIKit

final class HomeCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = HomeViewController(coordinator: self)
        self.navigationController.viewControllers = [viewController]
        
        print("Home navigationController: \(navigationController)")
    }
}

protocol HomeViewControllerDelegate: AnyObject {
    func startDetailViewController()
}

// MARK: - Home > Detail
extension HomeCoordinator: HomeViewControllerDelegate {
    func startDetailViewController() {
        let coordinator = DetailCoordinator(navigationController: self.navigationController)
        coordinator.parentCoordinator = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
     
        print("Home childCoordinators: \(coordinator)")
    }
}

// MARK: - Detail > Home
extension HomeCoordinator: DetailCoordinatorDelegate {
    func didEndDetailViewController(_ coordinator: DetailCoordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
        handleListContactViewControllerVisibility()
    }
    
    private func handleListContactViewControllerVisibility() {
        if let viewController = self.navigationController.viewControllers.last as? ModalViewControllerDismissingHandlable {
            viewController.viewControllerWillAppear()
        }
    }
}

// MARK: - ModalViewControllerDismissingHandlable
protocol ModalViewControllerDismissingHandlable {
    func viewControllerWillAppear()
}
