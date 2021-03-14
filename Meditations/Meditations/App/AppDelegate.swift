//
//  AppDelegate.swift
//  Meditations
//
//  Created by Emrah Akgül on 13.03.2021.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var navigationController: UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        navigationController = UINavigationController()
        let view = DashboardViewRouter.createModule(using:navigationController)
        navigationController?.viewControllers = [view]
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }

}

