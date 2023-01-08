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
    var networkServiceMock: NetworkServiceMock?
    var persistentProviderMock: PersistentProviderMock?
    var isObtainCartProducts = false
    var isFetchSearchedProducts = false
    var products: Products
    
    init(products: Products = .init(products: [], total: 0, skip: 0, limit: 0)) {
        self.products = products
    }
}

extension CatalogueInteractorSpy {
    
    func fetchCategories() {
        networkServiceMock?.fetchCategories(completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let categories):
                self.output?.didObtainCategories(categories: categories)
                
            case .failure:
                self.output?.didObtainCategories(categories: [])
            }
        })
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
    
    func obtainCartProducts() {}
    
    func obtainCartProductsCount() -> Int {
        return 0
    }
    
    func addToCart(products: [ShoppingCart.Product], completion: @escaping (ShoppingCart.PersistentState) -> Void) {
        return
    }
}
