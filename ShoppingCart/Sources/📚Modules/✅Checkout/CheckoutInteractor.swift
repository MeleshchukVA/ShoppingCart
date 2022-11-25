//
//  CheckoutInteractor.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 24.11.2022.
//

import Foundation

// MARK: - CheckoutInteractor class

final class CheckoutInteractor: BaseInteractor {
    
    weak var output: CheckoutInteractorOutput?
}

// MARK: - CheckoutInteractorInput

extension CheckoutInteractor: CheckoutInteractorInput {

    func addCart(_ body: [String: Any]) {
        networkService.addCart(body) { [weak self] result in
            switch result {
            case .success:
                self?.output?.didAddCart(success: true)

            case .failure:
                self?.output?.didAddCart(success: false)
            }
        }
    }
}
