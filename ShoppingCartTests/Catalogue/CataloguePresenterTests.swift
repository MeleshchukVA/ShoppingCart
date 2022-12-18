//
//  CatalogueInteractorTests.swift
//  ShoppingCartTests
//
//  Created by Владимир Мелещук on 07.12.2022.
//

import XCTest
@testable import ShoppingCart

final class CataloguePresenterTests: XCTestCase {
    
    var sut: CataloguePresenter!
    var interactorMock: CatalogueInteractorSpy!
    var viewControllerMock: CatalogueViewControllerMock!
    var routerMock: CatalogueRouterMock!
    var tableViewAdapterMock: CatalogueTableViewAdapterMock!
    var collectionViewAdapterMock: ProductCollectonViewAdapterMock!
    
    override func setUp() {
        super.setUp()
        setupMocks()
    }
    
    override func tearDown() {
        sut = nil
        interactorMock = nil
        viewControllerMock = nil
        routerMock = nil
        tableViewAdapterMock = nil
        super.tearDown()
    }
    
    private func setupMocks(
        interactorMock: CatalogueInteractorSpy = CatalogueInteractorSpy(),
        viewControllerMock: CatalogueViewControllerMock = CatalogueViewControllerMock(),
        routerMock: CatalogueRouterMock = CatalogueRouterMock(),
        tableViewAdapterMock: CatalogueTableViewAdapterMock = CatalogueTableViewAdapterMock(),
        collectionViewAdapterMock: ProductCollectonViewAdapterMock = ProductCollectonViewAdapterMock()
    ) {
        self.interactorMock = interactorMock
        self.viewControllerMock = viewControllerMock
        self.routerMock = routerMock
        self.tableViewAdapterMock = tableViewAdapterMock
        self.collectionViewAdapterMock = collectionViewAdapterMock
        
        sut = CataloguePresenter(
            router: routerMock,
            interactor: interactorMock,
            tableViewAdapter: tableViewAdapterMock,
            collectionViewAdapter: collectionViewAdapterMock
        )
        sut.view = viewControllerMock
        self.interactorMock.output = sut
    }
}

extension CataloguePresenterTests {
    
    // MARK: CatalogueViewOutput
    func test_Presenter_Did_Load_With_Success() {
        // Given
        setupMocks()
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssert(interactorMock.isFetchCategories == true)
        XCTAssert(viewControllerMock.isStartActivityIndicator == true)
    }
    
    func test_Presenter_Did_Load_With_Failure() {
        // Given
        setupMocks()
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertFalse(interactorMock.isFetchCategories == false)
        XCTAssertFalse(viewControllerMock.isStartActivityIndicator == false)
    }
    
    func test_Presenter_Did_Appear_With_Success() {
        // Given
        setupMocks()
        
        // When
        sut.viewDidAppear()
        
        // Then
        XCTAssert(interactorMock.isObtainCartProducts == true)
    }
    
    func test_Presenter_Did_Appear_With_Failure() {
        // Given
        setupMocks()
        
        // When
        sut.viewDidAppear()
        
        // Then
        XCTAssertFalse(interactorMock.isObtainCartProducts == false)
    }
    
    func test_Presenter_Search_Bar_Did_Editing_With_Some_Query_With_Success() {
        // Given
        setupMocks(interactorMock: CatalogueInteractorSpy(products: Products(
            products: [Product(
                id: 1,
                title: "Apple",
                productDescription: "",
                price: 1,
                discountPercentage: 1,
                rating: 1,
                stock: 1,
                brand: "",
                category: "",
                thumbnail: "",
                images: [""]
            )],
            total: 1, skip: 1, limit: 1)))
        
        let query = "Apple"
        
        // When
        sut.searchBarTextDidEndEditing(with: query)

        // Then
        XCTAssert(
            viewControllerMock.updateCollectionViewDataIsEmpty == false
        )
        XCTAssert(viewControllerMock.viewModels.allSatisfy { $0.title.contains(query) })
    }
}
