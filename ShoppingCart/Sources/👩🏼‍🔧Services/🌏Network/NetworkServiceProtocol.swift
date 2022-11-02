//
//  NetworkServiceProtocol.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 26.10.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchCategories(completion: @escaping (Result<Categories, Error>) -> Void)
    func fetchProducts(with name: String, completion: @escaping (Result<Products, Error>) -> Void)
}
