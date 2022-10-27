//
//  ReuseIdentifier.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 27.10.2022.
//

import UIKit

protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
