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
    
    var stubbedIsFetchCategories = false
    var stubbedIsObtainCartProducts = false
    var stubbedIsFetchSearchedProducts = false
}

extension CatalogueInteractorMock {
    
    func fetchCategories() {
        stubbedIsFetchCategories = true
    }
    
    func fetchSearchedProducts(by query: String, skip: Int) {
        stubbedIsFetchSearchedProducts = true
        return
    }
    
    func obtainCartProducts() {
        stubbedIsObtainCartProducts = true
    }
    
    func obtainCartProductsCount() -> Int {
        return 0
    }
    
    func addToCart(products: [ShoppingCart.Product], completion: @escaping (ShoppingCart.PersistentState) -> Void) {
        return
    }
    
    func testPrintBaseInteractor(ids: [Int]) {
        return
    }
}
