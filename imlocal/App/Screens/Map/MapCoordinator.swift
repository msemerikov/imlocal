//
//  MapCoordinator.swift
//  imlocal
//
//  Created by Mikhail Semerikov on 14.02.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import MapKit
import UIKit

class MapCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let mapViewController = MapViewController()
        navigationController.pushViewController(mapViewController, animated: false)
    }
    
    func start(location: CLLocationCoordinate2D?, radius: Int, delegate: MapViewDelegate) {
        let mapViewController = MapViewController()
        mapViewController.radius = radius
        mapViewController.delegate = delegate
        mapViewController.userCoordinate = location
        navigationController.pushViewController(mapViewController, animated: false)
    }
    
    func startSetupLocation(location: CLLocationCoordinate2D?, radius: Int, delegate: MapViewDelegate) {
        let mapViewController = MapViewController()
        mapViewController.radius = radius
        mapViewController.delegate = delegate
        mapViewController.isSetupLocation = true
        mapViewController.userCoordinate = location
        navigationController.pushViewController(mapViewController, animated: false)
    }
    
}

