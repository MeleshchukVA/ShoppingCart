//
//  TextField.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 22.11.2022.
//

import UIKit

// MARK: - TextField Class

final class TextField: UITextField {
    
    // MARK: Properties
    private let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    // MARK: Override methods
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
