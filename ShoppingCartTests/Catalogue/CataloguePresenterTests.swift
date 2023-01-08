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
    var collectionViewAdapterMock: ProductCollectionViewAdapterMock!
    var networkServiceMock: NetworkServiceMock!
    var persistentProviderMock: PersistentProviderMock!
    
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
        networkServiceMock = nil
        persistentProviderMock = nil
        super.tearDown()
    }
    
    private func setupMocks(
        interactorMock: CatalogueInteractorSpy = CatalogueInteractorSpy(),
        viewControllerMock: CatalogueViewControllerMock = CatalogueViewControllerMock(),
        routerMock: CatalogueRouterMock = CatalogueRouterMock(),
        tableViewAdapterMock: CatalogueTableViewAdapterMock = CatalogueTableViewAdapterMock(),
        collectionViewAdapterMock: ProductCollectionViewAdapterMock = ProductCollectionViewAdapterMock()
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
        interactorMock.networkServiceMock = networkServiceMock
        interactorMock.persistentProviderMock = persistentProviderMock
    }
}

extension CataloguePresenterTests {
    
    func test_PresenterDidLoad_WithSuccess() {
        // Given
        self.networkServiceMock = NetworkServiceMock()
        let categories = Categories(["Laptops"])
            
        setupMocks()
        
        networkServiceMock.resultForFetchCategories = .success(categories)
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssert(viewControllerMock.isStartActivityIndicator == true)
        XCTAssert(viewControllerMock.isHideTableView == true)
        XCTAssert(tableViewAdapterMock.isRestoreTableView == true)
        XCTAssert(viewControllerMock.isStopActivityIndicator == true)
    }
    
    func test_PresenterDidLoad_WithFailure() {
        // Given
        self.networkServiceMock = NetworkServiceMock()
        let error = NetworkErrors.dataIsEmpty
        
        setupMocks()
        
        networkServiceMock.resultForFetchCategories = .failure(error)
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssert(viewControllerMock.isHideTableView == true)
        XCTAssert(tableViewAdapterMock.message == "No categories found or connect to a network to download data")
        XCTAssert(viewControllerMock.isStopActivityIndicator == true)
    }
    
    func test_PresenterSearchBarDidEditing_WithSuccess() {
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
        XCTAssert(viewControllerMock.updateCollectionViewDataIsEmpty == false)
        XCTAssert(viewControllerMock.viewModels.allSatisfy { $0.title.contains(query) })
    }
}
