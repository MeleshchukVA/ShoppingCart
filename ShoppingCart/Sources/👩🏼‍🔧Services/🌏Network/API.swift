//
//  API.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 26.10.2022.
//

import Foundation

// Ссылки на API в формате String.
enum API {
    static let main = "https://dummyjson.com"
    
    enum TypeOf {
        static let categories = "/products/categories"
        static let products = "/products/category"
        static let productsSearch = "/products/search"
        static let addCart = "/carts/add"
        static let getUser = "/users/2"
    }
}
