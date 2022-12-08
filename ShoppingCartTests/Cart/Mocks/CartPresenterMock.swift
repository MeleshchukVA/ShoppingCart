//
//  CartPresenterMock.swift
//  ShoppingCartTests
//
//  Created by Владимир Мелещук on 08.12.2022.
//

import Foundation
@testable import ShoppingCart

final class CartPresenterMock {
    
    var stubbedProducts: [CartViewModel] = []
    var stubbedIsDidLoadProducts: Bool = false
    
    var stubbedProduct: ProductCDModel?
    var stubbedIsDidLoadProduct: Bool = false
    
    var stubbedIsViewDidLoad: Bool = false
}

extension CartPresenterMock: CartInteractorOutput {
    
    func didObtainCartProducts(products: [ShoppingCart.ProductCDModel]) {
        let viewModels = products.map { product in
            let procent = (Double(1) + Double(Int(product.discountPercentage)) / Double(100))
            let fullPrice = Double(product.price) * procent
            return CartViewModel(
                id: Int(product.id),
                name: product.title,
                thumbnail: product.thumbnail,
                brand: product.brand,
                price: UInt(product.price),
                fullPrice: UInt(Double(round(100 * fullPrice) / 100)),
                count: UInt(product.count),
                editHandler: {_ in },
                deleteHandler: {_ in },
                updateHandler: {_ in }
            )
        }
        self.stubbedProducts = viewModels
        stubbedIsDidLoadProducts = true
    }
    
    func didObtainCartProduct(product: ShoppingCart.ProductCDModel) {
        self.stubbedProduct = product
        stubbedIsDidLoadProduct = true
    }
}

extension CartPresenterMock: CartViewOutput {
    
    func viewDidLoad() {
        stubbedIsViewDidLoad = true
    }
    
    func checkoutButtonTapped() {
        return
    }
}
