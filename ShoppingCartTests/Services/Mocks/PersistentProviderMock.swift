//
//  PersistentProviderMock.swift
//  ShoppingCartTests
//
//  Created by Владимир Мелещук on 08.01.2023.
//

import UIKit
@testable import ShoppingCart

final class PersistentProviderMock {}

extension PersistentProviderMock: PersistentProviderProtocol {
    
    func update(
        models: [ShoppingCart.Product],
        action: ShoppingCart.PersistentState,
        completion: @escaping (Result<ShoppingCart.PersistentState, Error>
        ) -> Void) {
        return
    }
    
    func updateCountOfProduct(id: Int, count: Int) -> ShoppingCart.ProductCDModel? {
        return nil
    }
    
    func fetchProducts() -> [ShoppingCart.ProductCDModel] {
        return []
    }
    
    func deleteProduct(id: Int) {
        return
    }
}
