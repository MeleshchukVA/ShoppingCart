//
//  CatalogueInteractorTests.swift
//  ShoppingCartTests
//
//  Created by Владимир Мелещук on 07.12.2022.
//

import XCTest
@testable import ShoppingCart

final class CataloguePresenterTest: XCTestCase {
    
    var sut: CataloguePresenter!
    var interactorMock: CatalogueInteractorMock!
    var viewControllerMock: CatalogueViewControllerMock!
    var routerMock: CatalogueRouterMock!
    var tableViewAdapterMock: CatalogueTableViewAdapterMock!
    var collectionViewAdapterMock: ProductCollectonViewAdapterMock!
    
    override func setUp() {
        super.setUp()
        interactorMock = CatalogueInteractorMock()
        viewControllerMock = CatalogueViewControllerMock()
        routerMock = CatalogueRouterMock()
        tableViewAdapterMock = CatalogueTableViewAdapterMock()
        collectionViewAdapterMock = ProductCollectonViewAdapterMock()
        
        sut = CataloguePresenter(
            router: routerMock,
            interactor: interactorMock,
            tableViewAdapter: tableViewAdapterMock,
            collectionViewAdapter: collectionViewAdapterMock
        )
        sut.view = viewControllerMock
    }
    
    override func tearDown() {
        sut = nil
        interactorMock = nil
        viewControllerMock = nil
        routerMock = nil
        tableViewAdapterMock = nil
        super.tearDown()
    }
}

extension CataloguePresenterTest {
    
    func testPresenterDidLoad() {
        XCTAssertFalse(interactorMock.stubbedIsReloadCategories)
        sut.interactor.reload()
        XCTAssertTrue(interactorMock.stubbedIsReloadCategories)
        
        XCTAssertFalse(interactorMock.stubbedIsObtainCartProducts)
        sut.interactor.obtainCartProducts()
        XCTAssertTrue(interactorMock.stubbedIsObtainCartProducts)
        
        XCTAssertFalse(interactorMock.stubbedIsReloadProductByQuery)
        sut.interactor.reload(by: "iph", skip: 0)
        XCTAssertTrue(interactorMock.stubbedIsReloadProductByQuery)
    }
}
