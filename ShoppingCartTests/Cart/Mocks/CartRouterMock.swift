//
//  CartRouterMock.swift
//  ShoppingCartTests
//
//  Created by Владимир Мелещук on 08.12.2022.
//

import Foundation
@testable import ShoppingCart

final class CartRouterMock: CartRouterInput {
    
    var isShowCheckoutView = false
}

extension CartRouterMock {
    
    func showCheckoutView(products: [ShoppingCart.CartViewModel], context: ShoppingCart.CheckoutContext) {
        isShowCheckoutView = true
    }
    
    func showAlertController(viewModel: CartViewModel) {
        return
    }
}
