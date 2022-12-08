//
//  ProductPresenterMock.swift
//  ShoppingCartTests
//
//  Created by Владимир Мелещук on 07.12.2022.
//

import Foundation
@testable import ShoppingCart

final class ProductPresenterMock {
    
    var stubbedProducts: [Products] = []
    var stubbedIsDidLoadProducts: Bool = false
    var stubbedIsViewDidLoad: Bool = false
}

extension ProductPresenterMock: ProductInteractorOutput {
    
    func didObtainProducts(products: [Products]) {
        self.stubbedProducts = products
        stubbedIsDidLoadProducts = true
    }
}

extension ProductPresenterMock: ProductViewOutput {

    func viewDidLoad() {
        stubbedIsViewDidLoad = true
    }
}
