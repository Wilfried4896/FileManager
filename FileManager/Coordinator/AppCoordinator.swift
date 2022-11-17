//
//  AppCoordinator.swift
//  DataStorage
//
//  Created by Вилфриэд Оди on 07.11.2022.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var window: UIWindow?
    var childCoordinators: [Coordinator] = []
    var rootController: UIViewController?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        window?.makeKeyAndVisible()
        authPage()
    }
    
    func tabBarPage() {
        rootController = UITabBarController()
        window?.rootViewController = rootController
        
        let tabBArCoordinator = TabBarCoordinator(navigation: rootController as! UITabBarController)
        tabBArCoordinator.parent = self
        childCoordinators.append(tabBArCoordinator)
        tabBArCoordinator.start()
    }
    
    func authPage() {
        rootController = UINavigationController()
        window?.rootViewController = rootController
        
        let authCoordinator = AuthCoordinator(navigation: rootController as! UINavigationController)
        
        authCoordinator.parent = self
        childCoordinators.append(authCoordinator)
        authCoordinator.start()
    }
}
