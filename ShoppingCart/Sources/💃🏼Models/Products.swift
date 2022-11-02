//
//  Products.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 02.11.2022.
//

import Foundation

struct Products: Decodable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}

extension Products {
    
    struct Product: Decodable {
        let id: Int
        let title: String
        let description: String
        let price: Int
        let discountPercentage: Double
        let rating: Double
        let stock: Int
        let brand: String
        let category: String
        let thumbnail: String
        let images: [String]
    }
}
