//
//  CurrencyFormatter.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 17.11.2022.
//

import Foundation

enum CurrencyFormatterLocale: String {
    case russia = "ru_RU"
    case usa = "us_US"
}

final class CurrencyFormatter: NumberFormatter {
    static let shared = CurrencyFormatter()
    
    private override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurate(
        numberStyle: NumberFormatter.Style = .currency,
        localeType: CurrencyFormatterLocale = .usa
    ) {
        self.numberStyle = numberStyle
        self.maximumFractionDigits = 2
        self.minimumFractionDigits = 0
        self.locale = Locale(identifier: localeType.rawValue)
    }
    
    func string(from: Double) -> String? {
        string(from: NSNumber(value: from))
    }
}

extension CurrencyFormatter {
    override func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
