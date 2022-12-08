//
//  CatalogueInteractorMock.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 07.12.2022.
//
//

import Foundation
@testable import ShoppingCart

final class CatalogueInteractorMock: CatalogueInteractorInput {
    
    var stubbedIsReloadCategories: Bool = false
    var stubbedIsReloadProductByQuery: Bool = false
    var stubbedIsObtainCartProducts: Bool = false
}

extension CatalogueInteractorMock {
    
    func reload() {
        stubbedIsReloadCategories = true
    }
    
    func reload(by query: String, skip: Int) {
        stubbedIsReloadProductByQuery = true
    }
    
    func obtainCartProducts() {
        stubbedIsObtainCartProducts = true
    }
    
    func obtainCartProductsCount() -> Int {
        1
    }
    
    func addToCart(products: [ShoppingCart.Product], completion: @escaping (ShoppingCart.PersistentState) -> Void) {
        return
    }
    
    func testPrintBaseInteractor(ids: [Int]) {
        return
    }
}
