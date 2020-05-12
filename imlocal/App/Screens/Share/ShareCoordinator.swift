//
//  ActionCoordinator.swift
//  imlocal
//
//  Created by Denis on 17.12.2019.
//  Copyright © 2019 Denis. All rights reserved.
//

import UIKit

class ShareCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let shareViewController = ShareViewController.instantiate()
        shareViewController.tabBarItem = UITabBarItem(title: "Акции",
                                                      image: UIImage(named: "Share"),
                                                      selectedImage: UIImage(named: "Share")?.withRenderingMode(.alwaysOriginal))
        navigationController.pushViewController(shareViewController, animated: false)
        
    }
    
}
