//
//  Indicator.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 22.11.2022.
//

import Foundation

protocol Indicator {
    func stopActivityIndicator()
    func startActivityIndicator()
    func updateTabBarItems(badgeCount: Int)
}
