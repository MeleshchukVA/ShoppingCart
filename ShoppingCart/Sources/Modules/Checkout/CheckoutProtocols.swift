//
//  CheckoutProtocols.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 24.11.2022.
//

import Foundation

// MARK: - CheckoutModuleInput

protocol CheckoutModuleInput {
    var moduleOutput: CheckoutModuleOutput? { get }
}

// MARK: - CheckoutModuleOutput

protocol CheckoutModuleOutput: AnyObject {
    func clearCart(ids: [Int])
}

// MARK: - CheckoutViewInput

protocol CheckoutViewInput: AnyObject {}

// MARK: - CheckoutViewOutput

protocol CheckoutViewOutput: AnyObject {
    func buyButtonTapped()
    func dismissButtonTapped()
}

// MARK: - CheckoutInteractorInput

protocol CheckoutInteractorInput: AnyObject {
    func addCart(_ body: [String: Any])
}

// MARK: - CheckoutInteractorOutput

protocol CheckoutInteractorOutput: AnyObject {
    func didAddCart(success: Bool)
}

// MARK: - CheckoutRouterInput

protocol CheckoutRouterInput: AnyObject {
    func showSuccessAddCartAlert(completion: @escaping (Bool) -> Void)
    func showErrorAddCartAlert()
    func dismissModalView()
}
