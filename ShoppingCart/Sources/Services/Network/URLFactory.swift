//
//  URLFactory.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 26.10.2022.
//

import Foundation

enum URLFactory {
    private static let baseURLComponents: URLComponents = {
        let url = URL(string: API.main)!
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = []
        return urlComponents
    }()
    
    private static var baseURL: URL {
        return baseURLComponents.url!
    }
    
    static func getCategories() -> String {
        return baseURL
            .appendingPathComponent(API.TypeOf.categories)
            .absoluteString
    }
}
