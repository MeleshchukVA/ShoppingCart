//
//  GlobalConstants.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 17.11.2022.
//

import Foundation

enum ProductConstants {
    
    enum Network {
        
        static let limit = 10
        static let skip = 10
    }
    
    enum Layout {
        
        static let heightProductCard: CGFloat = 89
        static let itemsInRow: CGFloat = 2
        static let spacing: CGFloat = 9
        static let spacingLeft: CGFloat = 9
        static let spacingTop: CGFloat = 9
        static let spacingBottom: CGFloat = 20
        static let spacingRight: CGFloat = 23
        static let minimumInteritemSpacingForSectionAt: CGFloat = 17
        static let cornerRadius: CGFloat = 8
    }
}

enum Keys {
    
    static let isUserHasSeenOnboarding = "isUserHasSeenOnboarding"
    static let statusBar = "statusBar"
    static let titleTextColor = "titleTextColor"
    static let searchField = "searchField"
    static let placeholderLabel = "placeholderLabel"
    static let clearButton = "clearButton"
}
