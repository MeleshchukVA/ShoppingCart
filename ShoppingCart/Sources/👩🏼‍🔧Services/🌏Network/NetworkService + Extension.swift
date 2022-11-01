//
//  NetworkService + Extension.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 26.10.2022.
//

import Foundation

extension NetworkService: NetworkServiceProtocol {
    
    func fetchCategories(completion: @escaping (Result<Categories, Error>) -> Void) {
        let url = URLFactory.getCategories()
        self.baseRequest(url: url, completion: completion)
    }
}
