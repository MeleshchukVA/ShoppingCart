//
//  CheckoutProtocols.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 24.11.2022.
//

import Foundation

protocol CheckoutModuleInput {
    var moduleOutput: CheckoutModuleOutput? { get }
}

protocol CheckoutModuleOutput: AnyObject {
}

protocol CheckoutViewInput: AnyObject {}

protocol CheckoutViewOutput: AnyObject {
    func buyButtonTapped()
}

protocol CheckoutInteractorInput: AnyObject {
    func addCart(_ body: [String: Any])
}

protocol CheckoutInteractorOutput: AnyObject {
    func didAddCart(success: Bool)
}

protocol CheckoutRouterInput: AnyObject {
    func showSuccessAddCartAlert()
    func showErrorAddCartAlert()
}
