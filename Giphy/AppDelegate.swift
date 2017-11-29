//
//  AppDelegate.swift
//  Giphy
//
//  Created by Eugene Shcherbinock on 11/1/17.
//  Copyright © 2017 Eugene Shcherbinock. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let navigationController = UINavigationController()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        let gifsModuleConfigurator = GifsModuleConfigurator()
        gifsModuleConfigurator.configure(with: navigationController)
        navigationController.pushViewController(gifsModuleConfigurator.viewController, animated: true)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}
    
    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}

}
