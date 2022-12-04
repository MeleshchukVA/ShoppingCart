//
//  AppDelegate.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 24.10.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: Properties
    var window: UIWindow?
    private lazy var appDependency: AppDependency = AppDependency.makeDefault()
    private var appCoordinator: AppCoordinator?
    
    // MARK: Public methods
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        appCoordinator = AppCoordinator(window: window, appDependency: appDependency)
        appCoordinator?.start()
        self.window?.makeKeyAndVisible()
        return true
    }
}
