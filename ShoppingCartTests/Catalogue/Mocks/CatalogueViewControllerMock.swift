//
//  CatalogueViewControllerMock.swift
//  ShoppingCartTests
//
//  Created by Владимир Мелещук on 07.12.2022.
//

import Foundation
@testable import ShoppingCart

final class CatalogueViewControllerMock {
    
    var isStartActivityIndicator = false
    var isHideTableView = false
    var productsViewModel = [ProductViewModel]()
    var updateCollectionViewDataIsEmpty = false
    var viewModels: [ProductViewModel] = []
    var isStopActivityIndicator = false
    var badgeCount: Int?
}

extension CatalogueViewControllerMock: CatalogueViewInput {
    
    func updateCollectionViewData(adapter: ShoppingCart.ProductCollectionViewAdapterProtocol, isEmpty: Bool) {
        updateCollectionViewDataIsEmpty = isEmpty
        viewModels = adapter.viewModels
    }
    
    func hideTableView(isHidden: Bool) {
        isHideTableView = true
    }
    
    func hideCollectionView() {
        return
    }
    
    func stopActivityIndicator() {
        isStopActivityIndicator = true
    }
    
    func startActivityIndicator() {
        isStartActivityIndicator = true
    }
    
    func updateTabBarItems(badgeCount: Int) {
        self.badgeCount = badgeCount
    }
}
