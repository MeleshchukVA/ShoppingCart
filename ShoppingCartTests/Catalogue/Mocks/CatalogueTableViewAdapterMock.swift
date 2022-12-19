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
}

extension CatalogueTableViewAdapterMock {
    
    func setupTable(tableView: UITableView) {
        return
    }
    
    func update(viewModels: [ShoppingCart.CatalogueViewModel]) {
        self.viewModels = viewModels
    }
    
    func setEmptyMessage(message: String) {
        return
    }
    
    func restore() {
        isRestoreTableView = true
    }
}
