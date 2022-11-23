//
//  ProductInteractor.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 18.11.2022.
//  
//

import Foundation

// MARK: - Interactor

final class ProductInteractor: BaseInteractor {
    
    // MARK: Properties
	weak var output: ProductInteractorOutput?
}

// MARK: - InteractorInput

extension ProductInteractor: ProductInteractorInput {
    
    func reload(category: String) {
        self.networkService.fetchProducts(with: category) { [weak self] result in
            switch result {
            case .success(let products):
                self?.output?.didObtainProducts(products: [products])
                
            case .failure:
                self?.output?.didObtainProducts(products: [])
            }
        }
    }
}
