//
//  URLFactory.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 26.10.2022.
//

import Foundation

enum URLFactory {
    private static let baseURLComponents: URLComponents? = {
        var urlComponents = URLComponents(string: API.main)
        urlComponents?.queryItems = []
        return urlComponents
    }()
    
    private static var baseURL: URL? {
        return baseURLComponents?.url
    }
    
    static func getCategories() -> String? {
        return baseURL?
            .appendingPathComponent(API.TypeOf.categories)
            .absoluteString
    }
    
    static func getProducts(name: String) -> String? {
        return baseURL?
            .appendingPathComponent(API.TypeOf.products)
            .appendingPathComponent(name)
            .absoluteString
    }
}
