//
//  BaseInteractor.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 22.11.2022.
//

import Foundation

// MARK: - BaseInteractorInput Protocol

protocol BaseInteractorInput: AnyObject {
    func addToCart(products: [Product], completion: @escaping (PersistentState) -> Void)
    func obtainCartProductsCount() -> Int
}

// MARK: - BaseInteractor class

class BaseInteractor {
    
    // MARK: Properties
    let networkService: NetworkServiceProtocol
    let persistentProvider: PersistentProviderProtocol
    let queue = DispatchQueue(label: "BaseInteractor", qos: .background)
    
    // MARK: Init
    init(
        networkService: NetworkServiceProtocol,
        persistentProvider: PersistentProviderProtocol
    ) {
        self.networkService = networkService
        self.persistentProvider = persistentProvider
    }
}

// MARK: - BaseInteractor + BaseInteractorInput

extension BaseInteractor: BaseInteractorInput {
    
    func addToCart(products: [Product], completion: @escaping (PersistentState) -> Void) {
        queue.async { [weak self] in
            guard let self = self else { return }
            self.persistentProvider.update(models: products, action: .add) { result in
                switch result {
                case .success(let state):
                    completion(state)
                    
                case .failure:
                    break
                }
            }
        }
    }
    
    func obtainCartProductsCount() -> Int {
        persistentProvider.fetchProducts().count
    }
}
