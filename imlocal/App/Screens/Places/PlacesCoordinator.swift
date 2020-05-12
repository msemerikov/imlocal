//
//  PlacesCoordinator.swift
//  imlocal
//
//  Created by Denis on 17.12.2019.
//  Copyright © 2019 Denis. All rights reserved.
//

import UIKit

class PlacesCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let placesViewController = PlacesViewController.instantiate()
        placesViewController.tabBarItem = UITabBarItem(title: "Места", image: UIImage(named: "Places"), selectedImage: UIImage(named: "Places")?.withRenderingMode(.alwaysOriginal))
        
        navigationController.pushViewController(placesViewController, animated: false)
    }

}
