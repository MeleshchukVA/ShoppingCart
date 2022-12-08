//
//  CatalogueViewControllerMock.swift
//  ShoppingCartTests
//
//  Created by Владимир Мелещук on 07.12.2022.
//

import Foundation
@testable import ShoppingCart

final class CatalogueViewControllerMock: CatalogueViewInput {
    
    func updateCollectionViewData(adapter: ShoppingCart.ProductCollectionViewAdapterProtocol, isEmpty: Bool) {
        return
    }
    
    func hideTableView(isHidden: Bool) {
        return
    }
    
    func hideCollectionView() {
        return
    }
    
    func stopActivityIndicator() {
        return
    }
    
    func startActivityIndicator() {
        return
    }
    
    func updateTabBarItems(badgeCount: Int) {
        return
    }
}
