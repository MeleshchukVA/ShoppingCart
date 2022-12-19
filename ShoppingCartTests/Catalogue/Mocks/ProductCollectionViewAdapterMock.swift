//
//  ProductCollectionViewAdapterMock.swift
//  ShoppingCartTests
//
//  Created by Владимир Мелещук on 19.12.2022.
//

import Foundation
@testable import ShoppingCart

final class ProductCollectionViewAdapterMock: ProductCollectionViewAdapterProtocol {
    
    var delegate: ShoppingCart.ProductCollectionViewAdapterDelegate?
    var viewModels: [ShoppingCart.ProductViewModel] = []
    var boundsWidth: CGFloat = 0.0
}
