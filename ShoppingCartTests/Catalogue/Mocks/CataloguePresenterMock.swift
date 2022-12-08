//
//  CataloguePresenterMock.swift
//  ShoppingCartTests
//
//  Created by Владимир Мелещук on 07.12.2022.
//

import Foundation
@testable import ShoppingCart

final class CataloguePresenterMock {
    
    var stubbedCategories: [CatalogueViewModel] = []
    var stubbedProducts: [Product] = []
    
    var stubbedIsDidLoadProducts: Bool = false
    var stubbedIsDidLoadCategories: Bool = false
    var stubbedIsDidLoadProductsDB: Bool = false
    
    var stubbedIsViewDidLoad: Bool = false
    var stubbedIsViewDidAppear: Bool = false
    var stubbedIsSearchBarTextDidEndEditing: Bool = false
    var stubbedIsSearchBarCancelButtonClicked: Bool = false
}

extension CataloguePresenterMock: CatalogueInteractorOutput {
    
    func didObtainCategories(categories: Categories) {
        let viewModels = categories.map { CatalogueViewModel(id: UUID(), name: $0) }
        self.stubbedCategories = viewModels
        stubbedIsDidLoadCategories = true
    }
    
    func didObtainDBProducts(products: [ProductCDModel]) {
        stubbedIsDidLoadProductsDB = true
    }
    
    func didObtainProducts(products: [Products]) {
        guard let product = products.first else { return }
        self.stubbedProducts = product.products
        stubbedIsDidLoadProducts = true
    }
}

extension CataloguePresenterMock: CatalogueViewOutput {
    
    func viewDidAppear() {
        stubbedIsViewDidAppear = true
    }
    
    func searchBarTextDidEndEditing(with query: String) {
        stubbedIsSearchBarTextDidEndEditing = true
    }
    
    func searchBarCancelButtonClicked() {
        stubbedIsSearchBarCancelButtonClicked = true
    }
    
    func viewDidLoad() {
        stubbedIsViewDidLoad = true
    }
}
