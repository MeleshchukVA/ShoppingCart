//
//  AddCartResponse.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 22.11.2022.
//

import Foundation

struct AddCartResponse: Codable {
    let id: Int
    let total: Int
    let discountedTotal: Int
}
