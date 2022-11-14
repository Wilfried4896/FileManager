//
//  OnboardingCoordinator.swift
//  DataStorage
//
//  Created by Вилфриэд Оди on 07.11.2022.
//

import UIKit

class OnboardingCoordinator: Coordinator {
    weak var parent: Coordinator?
    
    var childCoordinators: [Coordinator] = []
    var navigation: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func start() {
        let vc =  OnboardingVC.instantiate()
        vc.coordinator = self
        navigation.pushViewController(vc, animated: true)
    }
    
    func didFinsh() {
        
    }
}
