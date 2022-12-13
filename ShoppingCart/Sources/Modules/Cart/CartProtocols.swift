//
//  CartProtocols.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 23.11.2022.
//

import Foundation

// MARK: - CartModuleInput
protocol CartModuleInput {
    var moduleOutput: CartModuleOutput? { get }
}

// MARK: - CartModuleOutput

protocol CartModuleOutput: AnyObject {}

// MARK: - CartViewInput

protocol CartViewInput: ViewInput {}

// MARK: - CartViewOutput

protocol CartViewOutput: AnyObject {
    func viewDidLoad()
    func checkoutButtonTapped()
}

// MARK: - CartInteractorInput

protocol CartInteractorInput: BaseInteractorInput {
    func obtainCartProducts()
    func deleteProduct(id: Int)
    func updateCountOfProduct(id: Int, count: Int)
}

// MARK: - CartInteractorOutput

protocol CartInteractorOutput: AnyObject {
    func didObtainCartProducts(products: [ProductCDModel])
    func didObtainCartProduct(product: ProductCDModel)
}

// MARK: - CartRouterInput

protocol CartRouterInput: AnyObject {
    func showAlertController(viewModel: CartViewModel)
    func showCheckoutView(products: [CartViewModel], context: CheckoutContext)
}
