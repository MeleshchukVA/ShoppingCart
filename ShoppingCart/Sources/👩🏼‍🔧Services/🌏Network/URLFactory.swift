//
//  URLFactory.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 26.10.2022.
//

import Foundation

enum URLFactory {

    private static let baseURLComponents: URLComponents? = {
        guard let url = URL(string: API.main) else { return nil }
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = []
        return urlComponents
    }()
    
    private static var baseURL: URL? {
        return baseURLComponents?.url
    }

    static func getCategories() -> String {
        return baseURL?
            .appendingPathComponent(API.TypeOf.categories)
            .absoluteString ?? ""
    }

    static func getProducts(name: String) -> String {
        return baseURL?
            .appendingPathComponent(API.TypeOf.products)
            .appendingPathComponent(name)
            .absoluteString ?? ""
    }

    static func getProducts(by query: String, skip: Int) -> String {
        var urlComponents = baseURLComponents
        let paramsQueryItem = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "limit", value: "\(ProductConstants.Network.limit)"),
            URLQueryItem(name: "skip", value: "\(skip)")
        ]
        urlComponents?.queryItems?.append(contentsOf: paramsQueryItem)
        return baseURL?
            .appendingPathComponent(API.TypeOf.productsSearch)
            .absoluteString ?? ""
    }

    static func addCart() -> String {
        return baseURL?
            .appendingPathComponent(API.TypeOf.addCart)
            .absoluteString ?? ""
    }

    static func getUser() -> String {
        return baseURL?
            .appendingPathComponent(API.TypeOf.getUser)
            .absoluteString ?? ""
    }
}
