//
//  UIColor + Extension.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 24.10.2022.
//

import UIKit.UIColor

extension UIColor {

    // Функция преобразует RGB в UIColor.
    static func rgba(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
    }
}
