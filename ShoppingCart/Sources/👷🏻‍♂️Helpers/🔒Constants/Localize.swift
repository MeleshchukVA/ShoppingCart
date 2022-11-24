//
//  Localize.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 24.10.2022.
//

import UIKit

enum Localize {
    
    static let cart = "Cart"
    static let catalogue = "Catalogue"
    static let profile = "Profile"

    enum Images {
        
        static let cartIcon: UIImage? = UIImage(named: "cart")
        static let cartMinusIcon: UIImage? = UIImage(named: "cart.badge.minus")
        static let cartPlusIcon: UIImage? = UIImage(named: "cart.badge.plus")
        static let catalogueIcon: UIImage? = UIImage(named: "magnifyingglass")
        static let ellipsisIcon: UIImage? = UIImage(named: "ellipsis")
        static let minusIcon: UIImage? = UIImage(named: "minus.square.fill")
        static let photo: UIImage? = UIImage(named: "photo")
        static let plusIcon: UIImage? = UIImage(named: "plus.square.fill")
        static let profileIcon: UIImage? = UIImage(named: "person")
    }
}
