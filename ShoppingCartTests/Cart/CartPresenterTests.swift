//
//  CartPresenterTests.swift
//  ShoppingCartTests
//
//  Created by Владимир Мелещук on 08.12.2022.
//

import XCTest
@testable import ShoppingCart

final class CartPresenterTest: XCTestCase {
    
    var sut: CartPresenter!
    var interactorMock: CartInteractorMock!
    var viewControllerMock: CartViewControllerMock!
    var routerMock: CartRouterMock!
    var tableViewAdapterMock: CartTableViewAdapterMock!
    
    override func setUp() {
        super.setUp()
        interactorMock = CartInteractorMock()
        viewControllerMock = CartViewControllerMock()
        routerMock = CartRouterMock()
        tableViewAdapterMock = CartTableViewAdapterMock()
        
        sut = CartPresenter(
            router: routerMock,
            interactor: interactorMock,
            tableViewAdapter: tableViewAdapterMock
        )
        sut.view = viewControllerMock
    }
    
    override func tearDown() {
        sut = nil
        interactorMock = nil
        viewControllerMock = nil
        routerMock = nil
        super.tearDown()
    }
}

extension CartPresenterTest {
    
    func testPresenterDidLoad() {
        XCTAssertFalse(interactorMock.stubbedIsObtainCartProducts)
        sut.interactor.obtainCartProducts()
        XCTAssertTrue(interactorMock.stubbedIsObtainCartProducts)
    }
}
