//
//  ProgrammaticallyInitializableViewProtocol.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 27.10.2022.
//

import Foundation

// Каждый ViewController наследуется от данного протокола.
protocol ProgrammaticallyInitializableViewProtocol: AnyObject {
    func setupView()
    func setupSubviews()
    func setupConstraints()
}
