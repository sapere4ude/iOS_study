//
//  DetailViewController.swift
//  ExCoordinator
//
//  Created by Kant on 1/17/24.
//

import UIKit

final class DetailViewController: UIViewController {

    weak var coordinator: DetailViewControllerDelegate?
    
    init(coordinator: DetailViewControllerDelegate) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        coordinator?.endDetail()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
    }
}

extension DetailViewController: ModalViewControllerDismissingHandlable {
    func viewControllerWillAppear() { }
}
