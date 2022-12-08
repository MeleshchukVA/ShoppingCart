//
//  ProductInteractorTests.swift
//  ShoppingCartTests
//
//  Created by Владимир Мелещук on 08.12.2022.
//

import XCTest
@testable import ShoppingCart

final class ProductInteractorTest: XCTestCase {
    
    var sut: ProductInteractor!
    var presenterMock: ProductPresenterMock!
    
    var networkServiceMock = NetworkServiceMock()
    var persistentProviderMock = PersistentProviderMock()
    
    override func setUp() {
        super.setUp()
        sut = ProductInteractor(
            networkService: networkServiceMock,
            persistentProvider: persistentProviderMock
        )
        sut.output = presenterMock
        presenterMock = ProductPresenterMock()
    }
    
    override func tearDown() {
        sut = nil
        presenterMock = nil
        super.tearDown()
    }
}

extension ProductInteractorTest {
    
    func testInteractorStubbedIsObtainCartProducts() {
        XCTAssertFalse(presenterMock.stubbedIsDidLoadProducts)
        sut.output?.didObtainProducts(products: [])
    }
}
