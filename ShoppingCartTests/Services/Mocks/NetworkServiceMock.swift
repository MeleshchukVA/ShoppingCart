//
//  NetworkServiceMock.swift
//  ShoppingCartTests
//
//  Created by Владимир Мелещук on 08.01.2023.
//

import UIKit
@testable import ShoppingCart

final class NetworkServiceMock {
    
    var resultForGetUsers: Result<ShoppingCart.User, Error>?
    var resultForFetchCategories: Result<ShoppingCart.Categories, Error>?
}

extension NetworkServiceMock: NetworkServiceProtocol {
    
    func fetchCategories(completion: @escaping (Result<ShoppingCart.Categories, Error>) -> Void) {
        completion(resultForFetchCategories!)
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
        completion(resultForGetUsers!)
    }
}
