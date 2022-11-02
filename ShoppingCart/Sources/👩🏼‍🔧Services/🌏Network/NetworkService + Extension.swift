//
//  NetworkService + Extension.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 26.10.2022.
//

import Foundation

extension NetworkService: NetworkServiceProtocol {
    
    func fetchCategories(completion: @escaping (Result<Categories, Error>) -> Void) {
        let url = URLFactory.getCategories() ?? nil
        baseRequest(url: url ?? "", completion: completion)
    }
    
    func fetchProducts(with name: String, completion: @escaping (Result<Products, Error>) -> Void) {
        let url = URLFactory.getProducts(name: name) ?? nil
        baseRequest(url: url ?? "", completion: completion)
    }
}
