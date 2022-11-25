//
//  UISearchBar + Extension.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 27.10.2022.
//

import UIKit.UISearchBar

extension UISearchBar {
    
    // MARK: Properties
    var compatibleSearchTextField: UITextField {
        guard #available(iOS 13.0, *) else { return legacySearchField }
        return self.searchTextField
    }

    private var legacySearchField: UITextField {
        if let textField = self.subviews.first?.subviews.last as? UITextField {
            return textField
        } else if let textField = self.value(forKey: "searchField") as? UITextField {
            return textField
        } else {
            return UITextField()
        }
    }
}
