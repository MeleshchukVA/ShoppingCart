//
//  ProgrammaticallyInitializableViewProtocol.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 27.10.2022.
//

import Foundation

// От данного протокола наследуются View и Cell в проекте.
protocol ProgrammaticallyInitializableViewProtocol: AnyObject {
    func setupView()
    func setupSubviews()
    func setupConstraints()
}
