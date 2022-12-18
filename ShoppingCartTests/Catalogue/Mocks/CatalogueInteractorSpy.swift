//
//  CatalogueInteractorMock.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 07.12.2022.
//
//

import Foundation
@testable import ShoppingCart

final class CatalogueInteractorSpy: CatalogueInteractorInput {
    
    var output: CatalogueInteractorOutput?
    var isFetchCategories = false
    var isObtainCartProducts = false
    var isFetchSearchedProducts = false
    
    var products: Products
    
    init(products: Products = .init(products: [], total: 0, skip: 0, limit: 0)) {
        self.products = products
    }
}

extension CatalogueInteractorSpy {
    
    func fetchCategories() {
        isFetchCategories = true
    }
    
    func fetchSearchedProducts(by query: String, skip: Int) {
        isFetchSearchedProducts = true
        let filterProduct: Products = Products(
            products: products.products.filter { $0.title.contains(query)},
            total: 1,
            skip: skip,
            limit: 10
        )
        output?.didObtainProducts(products: [filterProduct])
    }
    
    func obtainCartProducts() {
        isObtainCartProducts = true
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
