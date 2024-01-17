//
//  ViewController.swift
//  ExCoordinator
//
//  Created by Kant on 1/16/24.
//

import UIKit

class HomeViewController: UIViewController {

    weak var coordinator: HomeViewControllerDelegate?
    
    init(coordinator: HomeViewControllerDelegate) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        
        let action = UIAction { [weak self] _ in self?.didTapPlusBuuton() }
        let button = UIBarButtonItem(systemItem: .add, primaryAction: action)
        self.navigationItem.rightBarButtonItem = button
    }
    
    private func didTapPlusBuuton() {
        self.coordinator?.startDetailViewController()
    }
}

