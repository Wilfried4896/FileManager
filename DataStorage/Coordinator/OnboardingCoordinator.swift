//
//  OnboardingCoordinator.swift
//  DataStorage
//
//  Created by Вилфриэд Оди on 07.11.2022.
//

import UIKit

class OnboardingCoordinator: Coordinator {
    weak var parent: TabBarCoordinator?
    
    var childCoordinators: [Coordinator] = []
    var navigation: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func start() {
        let vc = UIStoryboard(name: "AppStoryboard", bundle: nil).instantiateViewController(withIdentifier: "OnboardingVC") as! OnboardingVC
        vc.coordinator = self
        navigation.navigationBar.prefersLargeTitles = true
        navigation.pushViewController(vc, animated: true)
    }
    
    func didFinsh() {
    }
    
}
