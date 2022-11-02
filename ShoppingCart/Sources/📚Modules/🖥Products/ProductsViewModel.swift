//
//  ProductsViewModel.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 02.11.2022.
//

import Foundation

struct ProductViewModel: Identifiable {
    var id: Int
    var title: String
    var description: String
    var price: UInt
    var discountPercentage: Double
    var rating: Double
    var stock: Int
    var brand: String
    var category: String
    var thumbnail: String
    var images: [String]
}
