//
//  AppDelegate.swift
//  imlocal
//
//  Created by Denis on 11.12.2019.
//  Copyright © 2019 Denis. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var coordinator: PlacesCoordinator?
    var window: UIWindow?
    let requestFactory = RequestFactory()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = MainTabBarViewController()
//        window?.rootViewController = MainViewController()
        let nav1 = UINavigationController()
        let mainView = MainViewController()
        nav1.viewControllers = [mainView]
        window?.rootViewController = nav1
        
        UITabBar.appearance().barTintColor = UIColor.imlocalBackgroundColor
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.imlocalMainColor], for:.selected)
        window?.makeKeyAndVisible()

//        let events = requestFactory.makeEventsRequestFatory()
//        events.eventsGet(page: 1, perPage: 10) { response in
//            switch response.result {
//            case .success(let events):
//                print(events)
//                print(response.request?.url)
//            case .failure(let error):
//                print(error)
//
//            }
//        }
        
//        let happening = requestFactory.makeHappeningsRequestFactory()
//        happening.happeningsGet(page: 1, perPage: 10) { response in
//            switch response.result {
//            case .success(let happening):
//                print(happening)
//                print(response.request?.url)
//            case .failure(let error):
//                print(error)
//                
//            }
//        }

        return true
    }



}

