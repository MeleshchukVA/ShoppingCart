//
//  CatalogueTableViewAdapterMock.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 07.12.2022.
//
//

import UIKit
@testable import ShoppingCart

final class CatalogueTableViewAdapterMock: CatalogueTableViewAdapterProtocol {}

extension CatalogueTableViewAdapterMock {
    
    func setupTable(tableView: UITableView) {
        return
    }
    
    func update(viewModels: [ShoppingCart.CatalogueViewModel]) {
        return
    }
    
    func setEmptyMessage(message: String) {
        return
    }
    
    func restore() {
        return
    }
}
