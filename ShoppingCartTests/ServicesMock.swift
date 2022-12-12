//
//  ServicesMock.swift
//  ShoppingCartTests
//
//  Created by Владимир Мелещук on 07.12.2022.
//

import Foundation
@testable import ShoppingCart

final class NetworkServiceMock: NetworkServiceProtocol {
    
    func fetchCategories(completion: @escaping (Result<ShoppingCart.Categories, Error>) -> Void) {
        return
    }
    
    func fetchProducts(with name: String, completion: @escaping (Result<ShoppingCart.Products, Error>) -> Void) {
        return
    }
    
    func fetchSearchedProducts(
        by query: String,
        skip: Int,
        completion: @escaping (Result<ShoppingCart.Products, Error>
        ) -> Void) {
        return
    }
    
    func addCart(_ body: [String: Any], completion: @escaping (Result<ShoppingCart.AddCartResponse, Error>) -> Void) {
        return
    }
    
    func getUser(completion: @escaping (Result<ShoppingCart.User, Error>) -> Void) {
        return
    }
}

final class PersistentProviderMock: PersistentProviderProtocol {
    
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
    
    func testPrint(ids: [Int]) {
        return
    }
}
