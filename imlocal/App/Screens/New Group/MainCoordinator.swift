//
//  MainCoordinator.swift
//  imlocal
//
//  Created by Mikhail Semerikov on 18.02.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let mainViewController = MainViewController()
        navigationController.pushViewController(mainViewController, animated: false)
    }
    
}

