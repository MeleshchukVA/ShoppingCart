//
//  ProductPresenterTests.swift
//  ShoppingCartTests
//
//  Created by Владимир Мелещук on 07.12.2022.
//

import XCTest
@testable import ShoppingCart

final class ProductPresenterTest: XCTestCase {
    
    var sut: ProductPresenter!
    var interactorMock: ProductInteractorMock!
    var viewControllerMock: ProductViewControllerMock!
    var routerMock: ProductRouterMock!
    var collectionViewAdapterMock: ProductCollectonViewAdapterMock!
    
    override func setUp() {
        super.setUp()
        interactorMock = ProductInteractorMock()
        viewControllerMock = ProductViewControllerMock()
        routerMock = ProductRouterMock()
        collectionViewAdapterMock = ProductCollectonViewAdapterMock()
        let viewModel = CatalogueViewModel(id: UUID(), name: "Shoes")
        
        sut = ProductPresenter(
            router: routerMock,
            interactor: interactorMock,
            collectionViewAdapter: collectionViewAdapterMock,
            viewModel: viewModel
        )
        sut.view = viewControllerMock
    }
    
    override func tearDown() {
        sut = nil
        interactorMock = nil
        viewControllerMock = nil
        routerMock = nil
        collectionViewAdapterMock = nil
        super.tearDown()
    }
}

extension ProductPresenterTest {
    
    func testPresenterDidLoad() {
        XCTAssertFalse(interactorMock.stubbedIsReloadCategories)
        sut.interactor.reload(category: "Shoes")
        XCTAssertTrue(interactorMock.stubbedIsReloadCategories)
    }
}
