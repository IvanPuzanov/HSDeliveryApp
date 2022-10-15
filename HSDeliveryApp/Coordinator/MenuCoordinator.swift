//
//  AppCoordinator.swift
//  HSDeliveryApp
//
//  Created by Ivan Puzanov on 14.10.2022.
//

import UIKit

class MenuCoordinator: Coordinator {
    // MARK: - Parameters
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    // MARK: - Initialization
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    func start() {
        let viewController = MainVC()
        viewController.tabBarItem = UITabBarItem(title: "Меню", image: UIImage(systemName: "doc.fill"), tag: 0)
        navigationController.pushViewController(viewController, animated: true)
    }
}
