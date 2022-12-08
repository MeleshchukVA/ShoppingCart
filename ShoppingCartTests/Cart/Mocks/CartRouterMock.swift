//
//  CartRouterMock.swift
//  ShoppingCartTests
//
//  Created by Владимир Мелещук on 08.12.2022.
//

import Foundation
@testable import ShoppingCart

final class CartRouterMock: CartRouterInput {
    
    func showCheckoutView(products: [ShoppingCart.CartViewModel]) {
        return
    }
    
    func showAlertController(viewModel: CartViewModel) {
        return
    }
}
