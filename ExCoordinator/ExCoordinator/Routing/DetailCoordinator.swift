//
//  DetailCoordinator.swift
//  ExCoordinator
//
//  Created by Kant on 1/17/24.
//

import UIKit

// TODO: DetailCoordinator 마저 만들고, DetailViewController 만들기
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
        
        print("Detail navigationController: \(navigationController)")
    }
}

protocol DetailCoordinatorDelegate: AnyObject {
    //func endDetailViewController(_ coordinator: DetailCoordinator)
    
    // 이렇게 바꿔야함
    func didEndDetailViewController(_ coordinator: DetailCoordinator)
}

extension DetailCoordinator: DetailCoordinatorDelegate {
    func didEndDetailViewController(_ coordinator: DetailCoordinator) {
        self.navigationController.dismiss(animated: true)
        self.parentCoordinator?.didEndDetailViewController(self)
        
    }
}
