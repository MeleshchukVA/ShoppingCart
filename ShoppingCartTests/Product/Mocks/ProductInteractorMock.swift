//
//  ProductInteractorMock.swift
//  ShoppingCartTests
//
//  Created by Владимир Мелещук on 07.12.2022.
//

import Foundation
@testable import ShoppingCart

final class ProductInteractorMock {
    
    var stubbedIsFetchProducts = false
}

extension ProductInteractorMock: ProductInteractorInput {
    
    func fetchProducts(category: String) {
        stubbedIsFetchProducts = true
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
