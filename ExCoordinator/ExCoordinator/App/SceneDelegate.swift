//
//  SceneDelegate.swift
//  ExCoordinator
//
//  Created by Kant on 1/16/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var coordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        
        coordinator = AppCoordinator(navigationController: navigationController)
        coordinator?.start()
        
        window.makeKeyAndVisible()
        self.window = window
    }
}

