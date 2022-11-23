//
//  AppCoordinator.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 26.10.2022.
//

import UIKit

// MARK: - Class

final class AppCoordinator {
    private let window: UIWindow
    private lazy var tabBarController = UITabBarController()
    private lazy var navigationControllers = AppCoordinator.makeNavigationControllers()
    private let appDependency: AppDependency
    private var isUserHasSeenOnboarding: Bool = false
    
    init(
        window: UIWindow,
        appDependency: AppDependency
    ) {
        self.window = window
        self.appDependency = appDependency
        navigationControllers = AppCoordinator.makeNavigationControllers()
        checkIfUserHasSeenOnboarding()
    }
    
    func start() {
        if isUserHasSeenOnboarding {
            startMainFlow()
        } else {
            startOnboardingFlow()
        }
    }
    
    private func startOnboardingFlow() {
        let onboardingVC = OnboardingViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            onboardingCompletion: { [weak self] completion in
            switch completion {
            case true:
                self?.userHasSeenOnboarding()
                self?.startMainFlow()
                
            case false:
                break
            }
        })
        
        window.rootViewController = onboardingVC
    }
    
    private func startMainFlow() {
        setupCatalogue()
        setupCart()
//        setupProfile()
        let navigationControllers = NavigationControllersType.allCases.compactMap {
            self.navigationControllers[$0]
        }
        tabBarController.setViewControllers(navigationControllers, animated: true)
        setupAppearanceTabBar(with: tabBarController)
        window.rootViewController = tabBarController
    }
    
    private func userHasSeenOnboarding() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: ProductConstants.UserDefaults.isUserHasSeenOnboarding)
    }
    
    private func checkIfUserHasSeenOnboarding() {
        let defaults = UserDefaults.standard
        self.isUserHasSeenOnboarding = defaults.bool(forKey: ProductConstants.UserDefaults.isUserHasSeenOnboarding)
    }
}

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
    
    func setupCatalogue() {
        guard let navController = self.navigationControllers[.catalogue] else {
            fatalError("something wrong with appCoordinator")
        }
        let context = CatalogueContext(moduleDependencies: appDependency)
        let container = CatalogueContainer.assemble(with: context)
        let catalogueVC = container.viewController
        catalogueVC.navigationItem.title = Localize.catalogue
        navController.setViewControllers([catalogueVC], animated: false)
        setupAppearanceNavigationBar()
    }
    
    func setupCart() {
        guard let navController = self.navigationControllers[.cart] else {
            fatalError("something wrong with appCoordinator")
        }
        let context = CartContext(moduleDependencies: appDependency)
        let container = CartContainer.assemble(with: context)
        let cartVC = container.viewController
        cartVC.navigationItem.title = Localize.cart
        navController.setViewControllers([cartVC], animated: false)
    }
//
//    func setupProfile() {
//        guard let navController = self.navigationControllers[.profile] else {
//            fatalError("something wrong with appCoordinator")
//        }
//        let context = ProfileContext(moduleDependencies: appDependency)
//        let container = ProfileContainer.assemble(with: context)
//        let profileVC = container.viewController
//        profileVC.navigationItem.title = Localize.profile
//        navController.setViewControllers([profileVC], animated: false)
//    }
    
    func setupAppearanceNavigationBar() {
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.backgroundColor = Colors.purple
        navigationBarAppearance.barTintColor = Colors.purple
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.01
        navigationBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: Font.sber(ofSize: Font.Size.twenty, weight: .bold) as Any
        ]
        navigationBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: Font.sber(ofSize: Font.Size.thirtyFour, weight: .bold) as Any,
            .paragraphStyle: paragraphStyle,
            .kern: 0.41
        ]
        navigationBarAppearance.tintColor = .white
        navigationBarAppearance.isTranslucent = false
        navigationBarAppearance.setBackgroundImage(UIImage(), for: .default)
        navigationBarAppearance.shadowImage = UIImage()
    }
    
    func setupAppearanceTabBar(with controller: UITabBarController) {
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.shadowImage = UIImage()
        tabBarAppearance.backgroundImage = UIImage()
        tabBarAppearance.backgroundColor = Colors.lightGray
        tabBarAppearance.barTintColor = Colors.lightGray
        controller.tabBar.unselectedItemTintColor = Colors.grayTabBar
        controller.selectedIndex = 0
        
        UITabBar.appearance().tintColor = Colors.purple2
        let tabBarItemAppearance = UITabBarItem.appearance()
        let textAtributes = [NSAttributedString.Key.font: Font.sber(ofSize: Font.Size.ten, weight: .bold)]
        tabBarItemAppearance.setTitleTextAttributes(textAtributes as [NSAttributedString.Key: Any], for: .normal)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: controller.tabBar.frame.width, y: 0))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = Colors.lightGray.cgColor
        shapeLayer.lineWidth = 0.4
        
        controller.tabBar.layer.addSublayer(shapeLayer)
    }
}

private enum NavigationControllersType: Int, CaseIterable {
    case catalogue, cart, profile
    var title: String {
        switch self {
        case .catalogue:
            return Localize.catalogue
            
        case .cart:
            return Localize.cart
            
        case .profile:
            return Localize.profile
        }
    }
    
    var image: UIImage? {
        switch self {
        case .catalogue:
            return Localize.Images.catalogueIcon
            
        case .cart:
            return Localize.Images.cartIcon
            
        case .profile:
            return Localize.Images.profileIcon
        }
    }
}
