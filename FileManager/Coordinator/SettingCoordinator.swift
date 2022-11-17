//
//  SettingCoordinator.swift
//  DataStorage
//
//  Created by Вилфриэд Оди on 11.11.2022.
//

import UIKit
import KeychainAccess

class SettingCoordinator: Coordinator {
    weak var parent: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigation: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func start() {
        let vc = SettingVC()
        vc.coordinator = self
        navigation.pushViewController(vc, animated: true)
    }
    
    func authChangedPassword() {
        let viewModel = AuthViewModel()
        let authVC = AuthenticationVC()
        authVC.title = "Поменять пароль"
        let nav = UINavigationController(rootViewController: authVC)
        nav.modalPresentationStyle = .fullScreen
        viewModel.removePassword()
        authVC.authViewModel = viewModel
        navigation.present(nav, animated: true)
    }
}
