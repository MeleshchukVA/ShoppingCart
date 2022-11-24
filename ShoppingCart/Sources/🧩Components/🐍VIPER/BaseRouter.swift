//
//  BaseRouter.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 02.11.2022.
//

import UIKit

class BaseRouter {
    
    var moduleDependencies: ModuleDependencies?

    var navigationControllerProvider: (() -> UINavigationController?)?
    var navigationController: UINavigationController? {
        self.navigationControllerProvider?()
    }

    var viewControllerProvider: (() -> UIViewController?)?
    var viewController: UIViewController? {
        self.viewControllerProvider?()
    }
}
