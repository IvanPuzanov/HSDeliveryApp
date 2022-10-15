//
//  ContactsCoordinator.swift
//  HSDeliveryApp
//
//  Created by Ivan Puzanov on 14.10.2022.
//

import UIKit

class ContactsCoordinator: Coordinator {
    // MARK: - Parameters
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    // MARK: - Initialization
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    func start() {
        let viewController = ContactsVC()
        viewController.tabBarItem = UITabBarItem(title: "Контакты", image: UIImage(systemName: "person.circle.fill"), tag: 1)
        navigationController.pushViewController(viewController, animated: true)
    }
}
