//
//  CatalogueInteractor.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 25.10.2022.
//
//

import Foundation

// MARK: - CatalogueInteractor class

final class CatalogueInteractor: BaseInteractor {
    
    weak var output: CatalogueInteractorOutput?
}

// MARK: - CatalogueInteractorInput

extension CatalogueInteractor: CatalogueInteractorInput {
    
    func fetchCategories() {
        networkService.fetchCategories { [weak self] result in
            switch result {
            case .success(let results):
                self?.output?.didObtainCategories(categories: results)
            
            case .failure:
                self?.output?.didObtainCategories(categories: [])
            }
        }
    }
    
    func fetchSearchedProducts(by query: String, skip: Int) {
        networkService.fetchSearchedProducts(by: query, skip: skip) { [weak self] result in
            switch result {
            case .success(let products):
                self?.output?.didObtainProducts(products: [products])
            
            case .failure:
                self?.output?.didObtainProducts(products: [])
            }
        }
    }
    
    func obtainCartProducts() {
        let products = persistentProvider.fetchProducts()
        output?.updateTabBarItemsWhenProductsCountIsNotEmpty(products: products)
    }
}
