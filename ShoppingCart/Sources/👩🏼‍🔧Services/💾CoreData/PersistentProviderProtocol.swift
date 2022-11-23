//
//  PersistentProviderProtocol.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 22.11.2022.
//

import Foundation

protocol PersistentProviderProtocol {
    func update(
        models: [Product],
        action: PersistentState,
        completion: @escaping (Result<PersistentState, Error>) -> Void
    )
    func updateCountOfProduct(id: Int, count: Int) -> ProductCDModel?
    func fetchProducts() -> [ProductCDModel]
    func deleteProduct(id: Int)
}
