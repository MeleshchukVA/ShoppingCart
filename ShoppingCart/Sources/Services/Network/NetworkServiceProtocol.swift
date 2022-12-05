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
    func fetchSearchedProducts(by query: String, skip: Int, completion: @escaping (Result<Products, Error>) -> Void)
    func addCart(_ body: [String: Any], completion: @escaping (Result<AddCartResponse, Error>) -> Void)
    func getUser(completion: @escaping (Result<User, Error>) -> Void)
}
