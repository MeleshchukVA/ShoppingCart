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

extension CataloguePresenterTests {
    
    // MARK: CatalogueViewOutput
    func test_Presenter_Did_Load_With_Success() {
        sut.viewDidLoad()
        XCTAssert(interactorMock.stubbedIsFetchCategories == true)
        XCTAssert(viewControllerMock.stubbedIsStartActivityIndicator == true)
    }
    
    func test_Presenter_Did_Load_With_Failure() {
        sut.viewDidLoad()
        XCTAssertFalse(interactorMock.stubbedIsFetchCategories == false)
        XCTAssertFalse(viewControllerMock.stubbedIsStartActivityIndicator == false)
    }
    
    func test_Presenter_Did_Appear_With_Success() {
        sut.viewDidAppear()
        XCTAssert(interactorMock.stubbedIsObtainCartProducts == true)
    }
    
    func test_Presenter_Did_Appear_With_Failure() {
        sut.viewDidAppear()
        XCTAssertFalse(interactorMock.stubbedIsObtainCartProducts == false)
    }
    
//    func test_Presenter_Search_Bar_Did_Editing_With_Some_Query() {
//        let query = "Apple"
//        sut.searchBarTextDidEndEditing(with: query)
//        XCTAssert(viewControllerMock.stubbedIsStartActivityIndicator == true)
//        XCTAssert(viewControllerMock.stubbedIsHideTableView == true)
//        XCTAssert(interactorMock.stubbedIsFetchSearchedProducts == true)
//    }
    
//    func test_Presenter_Search_Bar_Did_Editing_With_Empty_Query() {
//        var query = ""
//        sut.searchBarTextDidEndEditing(with: query)
//        XCTAssert(viewControllerMock.stubbedIsStartActivityIndicator == true)
//        XCTAssert(viewControllerMock.stubbedIsHideTableView == true)
//        XCTAssert(interactorMock.stubbedIsFetchSearchedProducts == false)
//    }
//    
//    func test_Search_Bar_Cancel_Button_Clicked() {
//        sut.searchBarCancelButtonClicked()
//        XCTAssert(viewControllerMock.stubbedIsStartActivityIndicator == true)
//        XCTAssert(viewControllerMock.stubbedIsHideTableView == true)
//        XCTAssert(interactorMock.stubbedIsFetchCategories == true)
//    }
//    
//    // MARK: CatalogueInteractorOutput
//    func test_Presenter_Did_Obtain_Categories() {
//        sut.didObtainCategories(categories: <#T##Categories#>)
//    }
//    
//    func test_Presenter_Update_Tab_Bar_Items_When_Products_Count_Is_Not_Empty() {
//        sut.updateTabBarItemsWhenProductsCountIsNotEmpty(products: <#T##[ProductCDModel]#>)
//    }
//    
//    func test_Presenter_did_Obtain_Products() {
//        sut.didObtainProducts(products: <#T##[Products]#>)
//    }
//    
    // MARK: CatalogueTableViewAdapterDelegate
//    func test_Presenter_Catalogue_Table_View_Adapter() {
//        sut.catalogueTableViewAdapter(
//            <#T##adapter: CatalogueTableViewAdapter##CatalogueTableViewAdapter#>,
//            didSelectComponentAt: <#T##IndexPath#>
//        )
//    }
    
//    // MARK: ProductCollectionViewAdapterDelegate
//    func test_Presenter_Will_Display() {
//        sut.willDisplay(at: <#T##Int#>)
//    }
}
