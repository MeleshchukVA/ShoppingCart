//
//  CartTableViewAdapterMock.swift
//  ShoppingCartTests
//
//  Created by Владимир Мелещук on 08.12.2022.
//

import UIKit
@testable import ShoppingCart

final class CartTableViewAdapterMock: CartTableViewAdapterProtocol {}

extension CartTableViewAdapterMock {
    
    func setupTable(tableView: UITableView) {
        return
    }
    
    func update(viewModels: [ShoppingCart.CartViewModel]) {
        return
    }
    
    func update(by id: Int, count: Int) {
        return
    }
    
    func setEmptyMessage(message: String) {
        return
    }
    
    func deleteItem(_ item: ShoppingCart.CartViewModel) {
        return
    }
    
    func restore() {
        return
    }
}
