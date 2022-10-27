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
        navigationControllers = AppCoordinator.makeNavigationControllers()
    }
    
    // MARK: Public methods
    func start() {
        if #available(iOS 13.0, *) {
            window.overrideUserInterfaceStyle = .light
        }
        
        // Задаем элементы UITabBarController: каталог, корзина.
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

// MARK: - Private methods

private extension AppCoordinator {
    
    static func makeNavigationControllers() -> [NavigationControllersType: UINavigationController] {
        // Результат - это словарь: ключ - енам NavigationControllersType, значение - UINavigationController.
        var result: [NavigationControllersType: UINavigationController] = [:]
        
        // Проходимся по каждому case'у в енаме NavigationControllersType.
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
        // Цвет фона tabBar'а.
        tabBarAppearance.backgroundColor = Colors.lightGray
        tabBarController.tabBar.standardAppearance = tabBarAppearance
        // Цвет иконки в tabBar'е, если она не выбрана.
        tabBarController.tabBar.unselectedItemTintColor = Colors.grayTabBar
        // Цвет иконки в tabBar'е, если она выбрана.
        UITabBar.appearance().tintColor = Colors.purple
        // Открывает по умолчанию экран, который будет задан первым в массиве ViewController'ов (индекс = 0).
        tabBarController.selectedIndex = 0
        
        let tabBarItemAppearance = UITabBarItemAppearance()
        // Шрифт для тайтла элемента tabBar'а, если он не выбран.
        tabBarItemAppearance.normal.titleTextAttributes = [.font: Font.sber(ofSize: Font.Size.ten, weight: .bold)]
        // Шрифт для тайтла элемента tabBar'а, если он выбран.
        tabBarItemAppearance.selected.titleTextAttributes = [.font: Font.sber(ofSize: Font.Size.ten, weight: .bold)]
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        
        // Полосочка над tabBar'ом.
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
        // Задний фон NavigationBar'а фиолетового цвета.
        navigationBarAppearance.backgroundColor = Colors.purple
        
        let paragraphStyle = NSMutableParagraphStyle()
        // Высота области NavigationBar'а.
        paragraphStyle.lineHeightMultiple = 1.01
        
        // Шрифт, цвет шрифта, размер текста, когда тайтл не large.
        navigationBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: Font.sber(ofSize: Font.Size.twenty, weight: .bold)
        ]
        // Шрифт, цвет шрифта, размер текста, paragraphStyle, расстояние между буквами (.kern), когда тайтл large.
        navigationBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: Font.sber(ofSize: Font.Size.thirtyFour, weight: .bold),
            .paragraphStyle: paragraphStyle,
            .kern: 0.41
        ]
        
        // Цвет кнопки "отменить" и прочих.
        UINavigationBar.appearance().tintColor = Colors.purple
        
        // Задаем внешний вид при разных видах navigationBar'а.
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
    
    var image: UIImage {
        switch self {
        case .catalogue:
            return Localize.Images.catalogueIcon
            
        case .cart:
            return Localize.Images.cartIcon
        }
    }
}
