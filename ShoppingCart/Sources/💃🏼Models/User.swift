//
//  User.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 22.11.2022.
//

import Foundation

struct User: Decodable {
    
    let id: Int
    let image: String
    let firstName: String
    let lastName: String
    let email: String
    let username: String
    let password: String
}
