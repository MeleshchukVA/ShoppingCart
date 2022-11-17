//
//  AppCoordinator.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 26.10.2022.
//

import UIKit

// MARK: - Class

final class AppCoordinator {
    
    // MARK: Properties
    private let window: UIWindow
    private let appDependency: AppDependency
    private lazy var navigationControllers = AppCoordinator.makeNavigationControllers()
    private lazy var tabBarController = UITabBarController()
    
    // MARK: Init
    init(
        window: UIWindow,
        appDependency: AppDependency
    ) {
        self.window = window
        self.appDependency = appDependency
    }
    
    // MARK: Public
    func start() {
        if #available(iOS 13.0, *) {
            window.overrideUserInterfaceStyle = .light
        }
        
        setupCatalogue()
        
        let navigationControllers = NavigationControllersType.allCases.compactMap {
            self.navigationControllers[$0]
        }

        tabBarController.setViewControllers(navigationControllers, animated: true)

        setupAppearanceTabBar(with: tabBarController)
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}

// MARK: - Private

private extension AppCoordinator {
    
    static func makeNavigationControllers() -> [NavigationControllersType: UINavigationController] {
        var result: [NavigationControllersType: UINavigationController] = [:]
        
        NavigationControllersType.allCases.forEach { navigationControllerKey in
            let navigationController = UINavigationController()
            let tabBarItem: UITabBarItem = UITabBarItem(
                title: navigationControllerKey.title,
                image: navigationControllerKey.image,
                tag: navigationControllerKey.rawValue
            )
            
            navigationController.tabBarItem = tabBarItem
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.navigationBar.sizeToFit()
            
            result[navigationControllerKey] = navigationController
        }
        
        return result
    }
    
    // Каталог.
    func setupCatalogue() {
        guard let navigationController = self.navigationControllers[.catalogue] else {
            fatalError("Something wrong with appCoordinator.")
        }
        
        let context = CatalogueContext(moduleDependencies: appDependency, moduleOutput: nil)
        let container = CatalogueContainer.assemble(with: context)
        let catalogueViewController = container.viewController
        
        catalogueViewController.navigationItem.title = Localize.catalogue
        navigationController.setViewControllers([catalogueViewController], animated: false)
        setupAppearanceNavigationBar(with: navigationController)
    }
    
    // Внешний вид TabBarController.
    func setupAppearanceTabBar(with tabBarController: UITabBarController) {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = Colors.lightGray
        tabBarController.tabBar.standardAppearance = tabBarAppearance
        tabBarController.tabBar.unselectedItemTintColor = Colors.grayTabBar
        UITabBar.appearance().tintColor = Colors.purple
        tabBarController.selectedIndex = 0
        
        let tabBarItemAppearance = UITabBarItemAppearance()
        tabBarItemAppearance.normal.titleTextAttributes = [
            .font: Font.sber(ofSize: Font.Size.ten, weight: .bold) as Any
        ]
        tabBarItemAppearance.selected.titleTextAttributes = [
            .font: Font.sber(ofSize: Font.Size.ten, weight: .bold) as Any
        ]
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: tabBarController.tabBar.frame.width, y: 0))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = Colors.lightWhite.cgColor
        shapeLayer.lineWidth = 0.4
        tabBarController.tabBar.layer.addSublayer(shapeLayer)
    }
    
    // Внешний вид NavigationBar.
    func setupAppearanceNavigationBar(with controller: UINavigationController) {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = Colors.purple
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.01
        
        navigationBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: Font.sber(ofSize: Font.Size.twenty, weight: .bold) as Any
        ]
        navigationBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: Font.sber(ofSize: Font.Size.thirtyFour, weight: .bold) as Any,
            .paragraphStyle: paragraphStyle,
            .kern: 0.41
        ]
        
        UINavigationBar.appearance().tintColor = Colors.purple
        
        controller.navigationBar.standardAppearance = navigationBarAppearance
        controller.navigationBar.compactAppearance = navigationBarAppearance
        controller.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
}

// MARK: - Enum

// Енам с тайтлом и SFSymbol'ом для каждого элемента UITabBarController'а.
private enum NavigationControllersType: Int, CaseIterable {
    case catalogue, cart
    
    var title: String {
        switch self {
        case .catalogue:
            return Localize.catalogue
            
        case .cart:
            return Localize.cart
        }
    }
    
    var image: UIImage? {
        switch self {
        case .catalogue:
            return Localize.Images.catalogueIcon
            
        case .cart:
            return Localize.Images.cartIcon
        }
    }
}
