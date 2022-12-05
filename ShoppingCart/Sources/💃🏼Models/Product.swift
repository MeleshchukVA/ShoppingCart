//
//  Product.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 22.11.2022.
//

import Foundation

struct Products: Decodable {
    
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}

struct Product: Decodable {
    
    let id: Int
    let title: String
    let productDescription: String
    let price: Int
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String
    let category: String
    let thumbnail: String
    let images: [String]

    enum CodingKeys: String, CodingKey {
        
        case id, title
        // Название оставляем productDescription, т.к. при создании
        // аттрибута с именем "description" ругается CoreData.
        case productDescription = "description"
        case price, discountPercentage, rating, stock, brand, category, thumbnail, images
    }
}
