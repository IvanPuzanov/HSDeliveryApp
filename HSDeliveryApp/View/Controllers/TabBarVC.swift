//
//  TabBarVC.swift
//  HSDeliveryApp
//
//  Created by Ivan Puzanov on 14.10.2022.
//

import UIKit

class TabBarVC: UITabBarController {

    private let menuCoordinator     = MenuCoordinator(navigationController: UINavigationController())
    private let contactsCoordinator = ContactsCoordinator(navigationController: UINavigationController())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuCoordinator.start()
        contactsCoordinator.start()
        
        UITabBar.appearance().tintColor = .systemOrange
        
        viewControllers = [menuCoordinator.navigationController, contactsCoordinator.navigationController]
    }

}
