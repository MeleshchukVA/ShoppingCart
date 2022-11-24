//
//  CheckoutPresenter.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 24.11.2022.
//

import Foundation

final class CheckoutPresenter {
    weak var view: CheckoutViewInput?
    weak var moduleOutput: CheckoutModuleOutput?
    
    private let router: CheckoutRouterInput
    private let interactor: CheckoutInteractorInput
    private let tableViewAdapter: CheckoutTableViewAdapterProtocol
    private let products: [CartViewModel]
    
    init(router: CheckoutRouterInput,
         interactor: CheckoutInteractorInput,
         products: [CartViewModel],
         tableViewAdapter: CheckoutTableViewAdapterProtocol) {
        self.router = router
        self.interactor = interactor
        self.tableViewAdapter = tableViewAdapter
        self.products = products
    }
}

extension CheckoutPresenter: CheckoutModuleInput {}

extension CheckoutPresenter: CheckoutViewOutput {
    func buyButtonTapped() {
        let body = prepareAddCartBody()
        interactor.addCart(body)
    }
    
    private func prepareAddCartBody() -> [String: Any] {
        var body = [String: Any]()
        var productsArray: [Any] = []
        body["userId"] = 1
        products.forEach { product in
            productsArray.append(product.prepareAddCartBody())
        }
        body["products"] = productsArray
        return body
    }
}

extension CheckoutPresenter: CheckoutInteractorOutput {
    func didAddCart(success: Bool) {
        DispatchQueue.main.async {
            if success {
                self.router.showSuccessAddCartAlert()
            } else {
                self.router.showErrorAddCartAlert()
            }
        }
    }
}
