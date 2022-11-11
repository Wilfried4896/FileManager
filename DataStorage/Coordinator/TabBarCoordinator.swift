//
//  TabBarCoordinator.swift
//  DataStorage
//
//  Created by Вилфриэд Оди on 11.11.2022.
//

import UIKit

class TabBarCoordinator: Coordinator {
    weak var parent: AppCoordinator?
    
    var childCoordinators: [Coordinator] = []
    var navigation: UITabBarController
    
    init(navigation: UITabBarController) {
        self.navigation = navigation
    }
    
    func start() {
        let onboardNavigation = UINavigationController()
        let onboardCoordinator = OnboardingCoordinator(navigation: onboardNavigation)
        onboardNavigation.tabBarItem = UITabBarItem(title: "Документ", image: UIImage(systemName: "folder.fill"), tag: 0)
        onboardCoordinator.parent = self


        let settingNavigation = UINavigationController()
        let settingCoordinator = SettingCoordinator(navigation: settingNavigation)
        settingNavigation.tabBarItem = UITabBarItem(title: "Настройка", image: UIImage(systemName: "gearshape.2.fill"), tag: 1)
        settingCoordinator.parent = self

        
        navigation.viewControllers = [onboardNavigation, settingNavigation]

        childCoordinators.append(onboardCoordinator)
        childCoordinators.append(settingCoordinator)

        onboardCoordinator.start()
        settingCoordinator.start()
    }
}
