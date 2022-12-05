//
//  IndicatorProtocol.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 24.11.2022.
//

import Foundation

// ActivityIndicator отображается на каждом экране при загрузке данных из сети.
protocol IndicatorProtocol {
    func stopActivityIndicator()
    func startActivityIndicator()
}
