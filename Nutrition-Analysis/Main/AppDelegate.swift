//
//  AppDelegate.swift
//  Nutrition-Analysis
//
//  Created by Mohamed Elsdody on 21/08/2021.
//

import UIKit

@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {
    var appCoordinator: AppCoordinator?
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        startApp()
        return true
    }

    func startApp() {
        
        let navController = UINavigationController()
        window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = AppCoordinator(window: window, navigationController: navController)
            appCoordinator?.start()
        }
    
}
