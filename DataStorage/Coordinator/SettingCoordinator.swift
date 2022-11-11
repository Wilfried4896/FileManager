//
//  SettingCoordinator.swift
//  DataStorage
//
//  Created by Вилфриэд Оди on 11.11.2022.
//

import UIKit

class SettingCoordinator: Coordinator {
    weak var parent: TabBarCoordinator?
    var childCoordinators: [Coordinator] = []
    var navigation: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func start() {
        let vc = UIStoryboard(name: "AppStoryboard", bundle: nil).instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
        
        vc.coordinator = self
        navigation.pushViewController(vc, animated: true)
    }
}
