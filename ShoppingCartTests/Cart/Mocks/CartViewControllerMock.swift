//
//  CartViewControllerMock.swift
//  ShoppingCartTests
//
//  Created by Владимир Мелещук on 08.12.2022.
//

import Foundation
@testable import ShoppingCart

final class CartViewControllerMock: CartViewInput {
    
    func stopActivityIndicator() {
        return
    }
    
    func startActivityIndicator() {
        return
    }
    
    func updateTabBarItems(badgeCount: Int) {
        return
    }
}
