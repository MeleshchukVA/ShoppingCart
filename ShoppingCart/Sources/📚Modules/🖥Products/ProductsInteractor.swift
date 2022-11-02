//
//  ProductsInteractor.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 02.11.2022.
//  
//

import Foundation

// MARK: - Interactor

final class ProductsInteractor {
    
    // MARK: Properties
	weak var output: ProductsInteractorOutput?
}

// MARK: - InteractorInput

extension ProductsInteractor: ProductsInteractorInput {
}
