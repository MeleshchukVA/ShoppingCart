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

extension CartPresenterTests {
    
    // MARK: CartViewOutput
    func test_Presenter_View_Did_Load_With_Success() {
        sut.viewDidLoad()
        XCTAssert(viewControllerMock.stubbedIsStartActivityIndicator == true)
        XCTAssert(interactorMock.stubbedIsObtainCartProducts == true)
    }
    
    func test_Presenter_View_Did_Load_With_Failure() {
        sut.viewDidLoad()
        XCTAssert(viewControllerMock.stubbedIsStartActivityIndicator == false)
        XCTAssert(interactorMock.stubbedIsObtainCartProducts == false)
    }
    
//    func test_Presenter_Checkout_Button_Tapped() {
//        sut.checkoutButtonTapped()
//        XCTAssert(routerMock.stubbedIsShowCheckoutView == true)
//    }
    
//    // MARK: CartInteractorOutput
//    func test_Presenter_Did_Obtain_Cart_Products() {
//        sut.didObtainCartProducts(products: <#T##[ProductCDModel]#>)
//    }
//    
//    func test_Presenter_Did_Obtain_Cart_Product() {
//        sut.didObtainCartProduct(product: <#T##ProductCDModel#>)
//    }
//    
//    // MARK: CartTableViewAdapterDelegate
//    func test_Presenter_Detele_Item() {
//        sut.deteleItem(viewModel: <#T##CartViewModel#>)
//    }
//    
//    func test_Presenter_Cart_Table_View_Adapter() {
//        sut.cartTableViewAdapter(
//            <#T##adapter: CartTableViewAdapter##CartTableViewAdapter#>,
//            didSelectComponentAt: <#T##IndexPath#>
//        )
//    }
}
