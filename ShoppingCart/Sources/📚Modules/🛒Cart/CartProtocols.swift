//
//  CartProtocols.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 23.11.2022.
//

import Foundation

protocol CartModuleInput {
    var moduleOutput: CartModuleOutput? { get }
}

protocol CartModuleOutput: AnyObject {}

protocol CartViewInput: ViewInput {}

protocol CartViewOutput: AnyObject {
    func viewDidLoad()
    func checkoutButtonTapped()
}

protocol CartInteractorInput: BaseInteractorInput {
    func obtainCartProducts()
    func deleteProduct(id: Int)
    func updateCountOfProduct(id: Int, count: Int)
}

protocol CartInteractorOutput: AnyObject {
    func didObtainCartProducts(products: [ProductCDModel])
    func didObtainCartProduct(product: ProductCDModel)
}

protocol CartRouterInput: AnyObject {
    func showAlertController(viewModel: CartViewModel)
    func showCheckoutView(products: [CartViewModel])
}
