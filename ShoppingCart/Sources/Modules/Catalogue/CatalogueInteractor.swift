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
    private let networkService: NetworkServiceProtocol
    
    // MARK: Init
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

// MARK: - InteractorInput

extension CatalogueInteractor: CatalogueInteractorInput {
    
    func reload() {
        networkService.fetchCategories { [weak self] result in
            switch result {
            case .success(let results):
                self?.output?.didObtainCategories(categories: results)
                
            case .failure:
                self?.output?.didObtainCategories(categories: [])
            }
        }
    }
}
