//
//  CartViewControllerMock.swift
//  ShoppingCartTests
//
//  Created by Владимир Мелещук on 08.12.2022.
//

import Foundation
@testable import ShoppingCart

final class CartViewControllerMock: CartViewInput {
    
    var stubbedIsStartActivityIndicator = false
}

extension CartViewControllerMock {
    
    func stopActivityIndicator() {
        return
    }
    
    func startActivityIndicator() {
        stubbedIsStartActivityIndicator = true
    }
    
    func updateTabBarItems(badgeCount: Int) {
        return
    }
}
