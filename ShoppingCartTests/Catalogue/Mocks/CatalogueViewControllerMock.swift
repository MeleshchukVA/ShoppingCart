//
//  CatalogueViewControllerMock.swift
//  ShoppingCartTests
//
//  Created by Владимир Мелещук on 07.12.2022.
//

import Foundation
@testable import ShoppingCart

final class CatalogueViewControllerMock: CatalogueViewInput {
    
    var isStartActivityIndicator = false
    var isHideTableView = false
    var productsViewModel = [ProductViewModel]()
    var updateCollectionViewDataIsEmpty = false
    var viewModels: [ProductViewModel] = []
}

extension CatalogueViewControllerMock {
    
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
        return
    }
    
    func startActivityIndicator() {
        isStartActivityIndicator = true
    }
    
    func updateTabBarItems(badgeCount: Int) {
        return
    }
}
