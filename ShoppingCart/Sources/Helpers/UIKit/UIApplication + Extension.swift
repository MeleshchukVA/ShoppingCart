//
//  UIApplication + Extension.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 22.11.2022.
//

import UIKit.UIApplication

extension UIApplication {
    
    var statusBarUIView: UIView? {
        if #available(iOS 13.0, *) {
            let tag = 38482458385
            if let statusBar = self.keyWindow?.viewWithTag(tag) {
                return statusBar
            } else {
                let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
                statusBarView.backgroundColor = Colors.purple
                statusBarView.tag = tag

                self.keyWindow?.addSubview(statusBarView)
                return statusBarView
            }
        } else {
            if responds(to: Selector((Keys.statusBar))) {
                return value(forKey: Keys.statusBar) as? UIView
            }
        }
        return nil
    }
}
