//
//  CatalogueInteractor.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 25.10.2022.
//  
//

import Foundation

// MARK: - Interactor

final class CatalogueInteractor {
    
    // MARK: Properties
	weak var output: CatalogueInteractorOutput?
}

// MARK: - InteractorInput

extension CatalogueInteractor: CatalogueInteractorInput {
}
