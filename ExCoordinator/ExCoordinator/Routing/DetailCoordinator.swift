//
//  DetailCoordinator.swift
//  ExCoordinator
//
//  Created by Kant on 1/17/24.
//

import UIKit

final class DetailCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: HomeCoordinator?
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let detailViewController = DetailViewController(coordinator: self)
        let destinationController = UINavigationController(rootViewController: detailViewController)
        self.navigationController.present(destinationController, animated: true)
    }
}

protocol DetailCoordinatorDelegate: AnyObject {
    func didEndDetailViewController(_ coordinator: DetailCoordinator)
}

extension DetailCoordinator: DetailCoordinatorDelegate {
    func didEndDetailViewController(_ coordinator: DetailCoordinator) {
        self.navigationController.dismiss(animated: true)
        self.parentCoordinator?.didEndDetailViewController(self)
        
    }
}

// MARK: - DetailViewControllerDelegate Implementation
protocol DetailViewControllerDelegate: AnyObject {
    func endDetail()
}

extension DetailCoordinator: DetailViewControllerDelegate {
    func endDetail() {
        self.navigationController.dismiss(animated: true)
        self.parentCoordinator?.didEndDetailViewController(self)
    }
}
