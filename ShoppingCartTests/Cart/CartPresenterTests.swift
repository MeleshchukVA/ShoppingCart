//
//  CartPresenterTests.swift
//  ShoppingCartTests
//
//  Created by Владимир Мелещук on 08.12.2022.
//

import XCTest
@testable import ShoppingCart

final class CartPresenterTests: XCTestCase {
    
    var sut: CartPresenter!
    var interactorMock: CartInteractorMock!
    var viewControllerMock: CartViewControllerMock!
    var routerMock: CartRouterMock!
    var tableViewAdapterMock: CartTableViewAdapterMock!
    var servicesMock: ServicesMock!
    
    override func setUp() {
        super.setUp()
        interactorMock = CartInteractorMock()
        viewControllerMock = CartViewControllerMock()
        routerMock = CartRouterMock()
        tableViewAdapterMock = CartTableViewAdapterMock()
        servicesMock = ServicesMock(networkService: NetworkServiceMock(), persistentProvider: PersistentProviderMock())
        
        sut = CartPresenter(
            router: routerMock,
            interactor: interactorMock,
            tableViewAdapter: tableViewAdapterMock,
            moduleDependencies: servicesMock
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

extension CartPresenterTests {
    
    func test_PresenterDidLoad_WithSuccess() {
        // When
        sut.viewDidLoad()
        
        //Then
        XCTAssert(viewControllerMock.isStartActivityIndicator == true)
        XCTAssert(interactorMock.isObtainCartProducts == true)
    }
    
    func test_PresenterDidLoad_WithFailure() {
        // When
        sut.viewDidLoad()
        
        //Then
        XCTAssert(viewControllerMock.isStartActivityIndicator == false)
        XCTAssert(interactorMock.isObtainCartProducts == false)
    }
    
    func test_CheckoutButtonTapped_WithFailure() {
        // When
        sut.checkoutButtonTapped()
        
        // Then
        XCTAssert(routerMock.isShowCheckoutView == false)
    }
}
