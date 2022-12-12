//
//  CatalogueViewControllerMock.swift
//  ShoppingCartTests
//
//  Created by Владимир Мелещук on 07.12.2022.
//

import Foundation
@testable import ShoppingCart

final class CatalogueViewControllerMock: CatalogueViewInput {
    
    var stubbedIsStartActivityIndicator = false
    var stubbedIsHideTableView = false
}

extension CatalogueViewControllerMock {
    
    func updateCollectionViewData(adapter: ShoppingCart.ProductCollectionViewAdapterProtocol, isEmpty: Bool) {
        return
    }
    
    func hideTableView(isHidden: Bool) {
        stubbedIsHideTableView = true
    }
    
    func hideCollectionView() {
        return
    }
    
    func stopActivityIndicator() {
        return
    }
    
    func startActivityIndicator() {
        stubbedIsStartActivityIndicator = true
    }
    
    func updateTabBarItems(badgeCount: Int) {
        return
    }
}
