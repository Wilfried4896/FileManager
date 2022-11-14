//
//  AuthCoordinator.swift
//  DataStorage
//
//  Created by Вилфриэд Оди on 11.11.2022.
//

import UIKit

class AuthCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigation: UINavigationController
    weak var parent: Coordinator?
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func start() {
        let viewModel = AuthViewModel()
        let vc = AuthenticationVC.instantiate()
        vc.coordinator = self
        vc.authViewModel = viewModel
        navigation.navigationBar.prefersLargeTitles = true
        navigation.pushViewController(vc, animated: true)
    }
    
    func tabBar() {
        let appCoor = parent as! AppCoordinator
        appCoor.tabBarPage()
        childDidFinish(self)
    }
}

