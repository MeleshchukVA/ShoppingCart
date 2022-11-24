//
//  BaseViewController.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 22.11.2022.
//

import UIKit

class BaseViewController: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarUIView?.backgroundColor = Colors.purple
    }
}

extension BaseViewController {
    
    func updateTabBarItems(badgeCount: Int) {
        tabBarController?.tabBar.items?[1].badgeColor = .red
        tabBarController?.tabBar.items?[1].badgeValue = badgeCount == -1 ? nil : "\(badgeCount)"
    }
}
