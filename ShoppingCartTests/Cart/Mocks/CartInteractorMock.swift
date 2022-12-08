//
//  CartInteractorMock.swift
//  ShoppingCartTests
//
//  Created by Владимир Мелещук on 08.12.2022.
//

import Foundation
@testable import ShoppingCart

final class CartInteractorMock {
    
    var stubbedIsObtainCartProducts: Bool = false
    var stubbedIsDeleteProduct: Bool = false
}

extension CartInteractorMock: CartInteractorInput {
    
    func obtainCartProducts() {
        stubbedIsObtainCartProducts = true
    }
    
    func deleteProduct(id: Int) {
        stubbedIsDeleteProduct = true
    }
    
    func updateCountOfProduct(id: Int, count: Int) {
        return
    }
    
    func addToCart(products: [ShoppingCart.Product], completion: @escaping (ShoppingCart.PersistentState) -> Void) {
        return
    }
    
    func obtainCartProductsCount() -> Int {
        1
    }
    
    func testPrintBaseInteractor(ids: [Int]) {
        return
    }
}
