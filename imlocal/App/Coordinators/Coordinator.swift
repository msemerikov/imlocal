//
//  Coordinator.swift
//  imlocal
//
//  Created by Denis on 18.12.2019.
//  Copyright © 2019 Denis. All rights reserved.
//

import UIKit


protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
