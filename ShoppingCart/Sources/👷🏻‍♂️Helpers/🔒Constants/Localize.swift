//
//  Localize.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 24.10.2022.
//

import UIKit

enum Localize {
    static let catalogue = "Catalogue"
    static let cart = "Cart"
    
    enum Images {
        static let catalogueIcon: UIImage? = UIImage(systemName: "magnifyingglass")
        static let cartIcon: UIImage? = UIImage(systemName: "cart")
        static let cartPlusIcon: UIImage? = UIImage(systemName: "cart.badge.plus")
        static let cartMinusIcon: UIImage? = UIImage(systemName: "cart.fill.badge.minus")
        static let profileIcon: UIImage? = UIImage(systemName: "person")
        static let heartIcon: UIImage? = UIImage(systemName: "heart")
        static let heartFillIcon: UIImage? = UIImage(systemName: "heart.fill")
    }
}
