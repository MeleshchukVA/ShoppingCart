//
//  NetworkService + Extension.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 26.10.2022.
//

import Foundation

extension NetworkService: NetworkServiceProtocol {
    
    func getUser(completion: @escaping (Result<User, Error>) -> Void) {
        let url = URLFactory.getUser()
        self.baseRequest(url: url, completion: completion)
    }

    func addCart(_ body: [String: Any], completion: @escaping (Result<AddCartResponse, Error>) -> Void) {
        let url = URLFactory.addCart()
        self.baseRequest(url: url, method: .post, body: body, completion: completion)
    }

    func fetchCategories(completion: @escaping (Result<Categories, Error>) -> Void) {
        let url = URLFactory.getCategories()
        self.baseRequest(url: url, completion: completion)
    }

    func fetchProducts(with name: String, completion: @escaping (Result<Products, Error>) -> Void) {
        let url = URLFactory.getProducts(name: name)
        self.baseRequest(url: url, completion: completion)
    }

    func fetchSearchedProducts(by query: String, skip: Int, completion: @escaping (Result<Products, Error>) -> Void) {
        let url = URLFactory.getProducts(by: query, skip: skip)
        self.baseRequest(url: url, completion: completion)
    }
}
