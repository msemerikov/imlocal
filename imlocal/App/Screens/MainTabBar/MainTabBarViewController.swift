//
//  MainTabBarViewController.swift
//  imlocal
//
//  Created by Denis on 17.12.2019.
//  Copyright © 2019 Denis. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController, Storyboarded {

    let placesCoordinator = PlacesCoordinator(navigationController: UINavigationController())
    let shareCoordinator = ShareCoordinator(navigationController: UINavigationController())
    let eventsCoordinator = EventsCoordinator(navigationController: UINavigationController())
    override func viewDidLoad() {
        super.viewDidLoad()
        placesCoordinator.start()
        shareCoordinator.start()
        eventsCoordinator.start()
        viewControllers = [placesCoordinator.navigationController,
                           shareCoordinator.navigationController,
                           eventsCoordinator.navigationController]
        
        
    }
    
    

}
