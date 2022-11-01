//
//  Font.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 24.10.2022.
//

import UIKit.UIFont

enum Font {
    enum Size {
        static let ten: CGFloat = 10.0
        static let eleven: CGFloat = 11.0
        static let thirteen: CGFloat = 13.0
        static let fouthteen: CGFloat = 14.0
        static let fithteen: CGFloat = 15.0
        static let seventeen: CGFloat = 17.0
        static let twenty: CGFloat = 20.0
        static let twentyEight: CGFloat = 28.0
        static let thirtyFour: CGFloat = 34.0
    }
    
    enum Weight {
        case regular, bold
    }
    
    // Функция возвращает шрифты в зависимости от их толщины.
    static func sber(ofSize size: CGFloat, weight: Weight) -> UIFont {
        switch weight {
        case .regular:
            return UIFont(name: "SBSansInterface-Regular", size: size)!
            
        case .bold:
            return UIFont(name: "SBSansDisplay-Semibold", size: size)!
        }
    }
}
