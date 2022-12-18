//
//  ProductCollectionViewAdapterMock.swift
//  ShoppingCartTests
//
//  Created by Владимир Мелещук on 07.12.2022.
//

import Foundation
@testable import ShoppingCart

final class ProductCollectonViewAdapterMock: ProductCollectionViewAdapterProtocol {
    
    var delegate: ShoppingCart.ProductCollectionViewAdapterDelegate?
    var viewModels: [ShoppingCart.ProductViewModel] = []
    var boundsWidth: CGFloat = 0
}
