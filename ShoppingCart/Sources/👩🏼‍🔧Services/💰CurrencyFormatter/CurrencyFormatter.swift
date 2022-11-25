//
//  CurrencyFormatter.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 17.11.2022.
//

import Foundation

// MARK: - Enum

enum CurrencyFormatterLocale: String {
    
    case russia = "ru_RU"
    case usa = "us_US"
}

// MARK: - CurrencyFormatter Class

final class CurrencyFormatter: NumberFormatter {
    
    // MARK: Properties
    static let shared = CurrencyFormatter()

    // MARK: Init
    private override init() {
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - CurrencyFormatter public methods

extension CurrencyFormatter {
    
    func configurate(
        numberStyle: NumberFormatter.Style = .currency,
        localeType: CurrencyFormatterLocale = .usa
    ) {
        self.numberStyle = numberStyle
        self.maximumFractionDigits = 2
        self.minimumFractionDigits = 0
        self.locale = Locale(identifier: localeType.rawValue)
    }

    func convertTostring(from: Double) -> String? {
        string(from: NSNumber(value: from))
    }
}
