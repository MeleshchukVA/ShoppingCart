//
//  CartInteractorTests.swift
//  ShoppingCartTests
//
//  Created by Владимир Мелещук on 08.12.2022.
//

import XCTest
@testable import ShoppingCart

final class CartInteractorTest: XCTestCase {

    var sut: CartInteractor!
    var presenterMock: CartPresenterMock!
    
    var networkServiceMock = NetworkServiceMock()
    var persistentProviderMock = PersistentProviderMock()
    
    override func setUp() {
        super.setUp()
        sut = CartInteractor(
            networkService: networkServiceMock,
            persistentProvider: persistentProviderMock
        )
        sut.output = presenterMock
        presenterMock = CartPresenterMock()
    }
    
    override func tearDown() {
        sut = nil
        presenterMock = nil
        super.tearDown()
    }
}

extension CartInteractorTest {
    
    func testInteractorStubbedIsObtainCartProducts() {
        XCTAssertFalse(presenterMock.stubbedIsDidLoadProducts)
        let products = persistentProviderMock.fetchProducts()
        sut.output?.didObtainCartProducts(products: persistentProviderMock.fetchProducts())
        if let product = products.first {
            sut.output?.didObtainCartProduct(product: product)
        }
    }
}
