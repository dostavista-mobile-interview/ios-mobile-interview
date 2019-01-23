//
//  AppDelegate.swift
//  ios-mobile-interview
//
//  Created by Boris Bengus on 28.08.2018.
//  Copyright © 2018 Portal OOO. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window
        
        let dostavistaApiClient = DefaultDostavistaApiClient()
        let orderDataProvider = DefaultOrderDataProvider(dostavistaApiClient: dostavistaApiClient)
        
        let orderListViewController = OrderListViewController(orderDataProvider: orderDataProvider)
        let navigationViewController = UINavigationController(rootViewController: orderListViewController)
        navigationViewController.navigationBar.isTranslucent = false
        navigationViewController.navigationBar.tintColor = .black
        
        window.rootViewController = navigationViewController
        
        return true

    }
}

