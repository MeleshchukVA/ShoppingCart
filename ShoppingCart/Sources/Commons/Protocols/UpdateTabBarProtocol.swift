//
//  UpdateTabBarProtocol.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 24.11.2022.
//

import Foundation

// Протокол отвечает за увеличение числа покупок в таб баре.
protocol UpdateTabBarProtocol {
    func updateTabBarItems(badgeCount: Int)
}
