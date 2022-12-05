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
        
        // MARK: Commons
        static let placeholderIcon: UIImage? = UIImage(named: "placeholder")
        
        // MARK: TabBar
        static let cartIcon: UIImage? = UIImage(named: "cart")
        static let catalogueIcon: UIImage? = UIImage(named: "search")
        static let profileIcon: UIImage? = UIImage(named: "person")

        // MARK: Product
        static let cartPlusIcon: UIImage? = UIImage(named: "cart.badge.plus")
        static let cartMinusIcon: UIImage? = UIImage(named: "cart.badge.minus")
        
        // MARK: Cart
        static let ellipsisIcon: UIImage? = UIImage(named: "ellipsis")
        static let minusIconGray: UIImage? = UIImage(named: "minus.square.fill")
        static let minusIconPurple: UIImage? = UIImage(named: "minus.square.fill.purple")
        static let plusIcon: UIImage? = UIImage(named: "plus.square.fill")
        
        // MARK: Checkout
        static let xmarkIcon: UIImage? = UIImage(named: "xmark")
        
        // MARK: Catalogue
        static let chevronImage = UIImage(named: "chevron.right")
    }
}
