//
//  EventsCoordinator.swift
//  imlocal
//
//  Created by Denis on 17.12.2019.
//  Copyright © 2019 Denis. All rights reserved.
//

import UIKit

class EventsCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let eventsViewController = EventsViewController.instantiate()
        eventsViewController.tabBarItem = UITabBarItem(title: "События",
                                                       image: UIImage(named: "Events"),
                                                       selectedImage: UIImage(named: "Events")?.withRenderingMode(.alwaysOriginal))
        navigationController.pushViewController(eventsViewController, animated: false)
    }
    
}
