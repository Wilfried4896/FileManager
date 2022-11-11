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
    weak var parent: AppCoordinator?
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func start() {
        let vc = UIStoryboard(name: "AppStoryboard", bundle: nil).instantiateViewController(withIdentifier: "AuthenticationVC") as! AuthenticationVC
        vc.coordinator = self
        navigation.pushViewController(vc, animated: true)
    }
}

