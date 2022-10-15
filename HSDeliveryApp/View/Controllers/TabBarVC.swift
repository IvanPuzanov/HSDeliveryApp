//
//  TabBarVC.swift
//  HSDeliveryApp
//
//  Created by Ivan Puzanov on 14.10.2022.
//

import UIKit

class TabBarVC: UITabBarController {

    // MARK: - Coordinators
    private let menuCoordinator     = MenuCoordinator(navigationController: UINavigationController())
    private let contactsCoordinator = ContactsCoordinator(navigationController: UINavigationController())
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        launchCoordinators()
        configure()
    }
    
    // MARK: - Handle methods
    private func launchCoordinators() {
        menuCoordinator.start()
        contactsCoordinator.start()
    }
    
    // MARK: - Configuration
    private func configure() {
        UITabBar.appearance().tintColor = .systemOrange
        viewControllers = [menuCoordinator.navigationController, contactsCoordinator.navigationController]
    }

}
