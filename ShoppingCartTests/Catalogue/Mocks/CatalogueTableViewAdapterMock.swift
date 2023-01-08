//
//  CatalogueTableViewAdapterMock.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 07.12.2022.
//
//

import UIKit
@testable import ShoppingCart

final class CatalogueTableViewAdapterMock: CatalogueTableViewAdapterProtocol {
    
    var viewModels: [ShoppingCart.CatalogueViewModel]?
    var isRestoreTableView = false
    var message: String?
}

extension CatalogueTableViewAdapterMock {
    
    func setupTable(tableView: UITableView) {
        return
    }
    
    func update(viewModels: [ShoppingCart.CatalogueViewModel]) {
        self.viewModels = viewModels
    }
    
    func setEmptyMessage(message: String) {
        self.message = message
    }
    
    func restore() {
        isRestoreTableView = true
    }
}
