//
//  ProductViewControllerMock.swift
//  ShoppingCartTests
//
//  Created by Владимир Мелещук on 07.12.2022.
//

import Foundation
@testable import ShoppingCart

final class ProductViewControllerMock: ProductViewInput {
    
    var isStartActivityIndicator = false
}
 
extension ProductViewControllerMock {
    
    func updateCollectionViewData(adapter: ShoppingCart.ProductCollectionViewAdapterProtocol, isEmpty: Bool) {
        return
    }
    
    func stopActivityIndicator() {
        return
    }
    
    func startActivityIndicator() {
        isStartActivityIndicator = true
    }
    
    func updateTabBarItems(badgeCount: Int) {
        return
    }
}
