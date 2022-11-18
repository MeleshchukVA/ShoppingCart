//
//  ProductInteractor.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 18.11.2022.
//  
//

import Foundation

// MARK: - Interactor

final class ProductInteractor {
    
    // MARK: Properties
	weak var output: ProductInteractorOutput?
}

// MARK: - InteractorInput

extension ProductInteractor: ProductInteractorInput {
}
