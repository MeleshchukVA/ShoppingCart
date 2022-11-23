//
//  URLFactory.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 26.10.2022.
//

import Foundation

enum URLFactory {
    private static var baseURL: URL {
        return baseURLComponents.url!
    }
    
    private static let baseURLComponents: URLComponents = {
        let url = URL(string: API.main)!
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = []
        return urlComponents
    }()
    
    static func getCategories() -> String {
        let urlComponents = baseURLComponents
        return urlComponents.url!
            .appendingPathComponent(API.TypeOf.categories)
            .absoluteString
    }
    
    static func getProducts(name: String) -> String {
        let urlComponents = baseURLComponents
        return urlComponents.url!
            .appendingPathComponent(API.TypeOf.products)
            .appendingPathComponent(name)
            .absoluteString
    }
    
    static func getProducts(by query: String, skip: Int) -> String {
        var urlComponents = baseURLComponents
        let paramsQueryItem = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "limit", value: "\(ProductConstants.Network.limit)"),
            URLQueryItem(name: "skip", value: "\(skip)")
        ]
        urlComponents.queryItems?.append(contentsOf: paramsQueryItem)
        return urlComponents.url!
            .appendingPathComponent(API.TypeOf.productsSearch)
            .absoluteString
    }
    
    static func addCart() -> String {
        let urlComponents = baseURLComponents
        return urlComponents.url!
            .appendingPathComponent(API.TypeOf.addCart)
            .absoluteString
    }
    
    static func getUser() -> String {
        let urlComponents = baseURLComponents
        return urlComponents.url!
            .appendingPathComponent(API.TypeOf.getUser)
            .absoluteString
    }
}
