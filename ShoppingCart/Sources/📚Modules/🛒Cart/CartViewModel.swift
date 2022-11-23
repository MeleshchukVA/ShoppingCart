//
//  CartViewModel.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 23.11.2022.
//

import Foundation

struct CartViewModel: Identifiable {
    var id: Int
    var name: String
    var thumbnail: String
    var brand: String
    var price: UInt
    var fullPrice: UInt
    var count: UInt
    var editHandler: (Int) -> Void
    var deleteHandler: (Int) -> Void
    var updateHandler: ((Int, Int)) -> Void
}

extension CartViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension CartViewModel: Equatable {
    static func == (lhs: CartViewModel, rhs: CartViewModel) -> Bool {
        lhs.id == rhs.id && lhs.count == rhs.count
    }
}

extension CartViewModel {
    func prepareAddCartBody() -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["id"] = id
        dict["quantity"] = count
        return dict
    }
}
