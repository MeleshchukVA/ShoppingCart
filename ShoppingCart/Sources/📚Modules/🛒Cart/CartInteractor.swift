//
//  CartInteractor.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 23.11.2022.
//

import Foundation

// MARK: - CartInteractor class

final class CartInteractor: BaseInteractor {
    
    weak var output: CartInteractorOutput?
}

// MARK: - CartInteractorInput

extension CartInteractor: CartInteractorInput {
    
    func obtainCartProducts() {
        let products = persistentProvider.fetchProducts()
        output?.didObtainCartProducts(products: products)
    }

    func deleteProduct(id: Int) {
        persistentProvider.deleteProduct(id: id)
    }

    func updateCountOfProduct(id: Int, count: Int) {
        guard let updatedProduct = persistentProvider.updateCountOfProduct(id: id, count: count) else { return }
        output?.didObtainCartProduct(product: updatedProduct)
    }
}
