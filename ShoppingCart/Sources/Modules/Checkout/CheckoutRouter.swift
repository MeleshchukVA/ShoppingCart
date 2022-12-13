//
//  CheckoutRouter.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 24.11.2022.
//

import UIKit

// MARK: - CheckoutRouter class

final class CheckoutRouter: BaseRouter {}

// MARK: - CheckoutRouterInput

extension CheckoutRouter: CheckoutRouterInput {
    
    func showSuccessAddCartAlert(completion: @escaping (Bool) -> Void) {
        let successAction = UIAlertAction(title: "Ok", style: .cancel) { _ in
            // Закрываем экран модуля Checkout.
            DispatchQueue.main.async {
                self.viewController?.dismiss(animated: true)
                self.navigationController?.popViewController(animated: true)
            }
            completion(true)
        }
        successAction.setValue(Colors.purple2, forKey: Keys.titleTextColor)
        
        let alertController = UIAlertController(
            title: "Success",
            message: "Your order send!",
            preferredStyle: .alert
        )
        alertController.addAction(successAction)
        
        self.viewController?.present(alertController, animated: true)
    }

    func showErrorAddCartAlert() {
        let cancelAction = UIAlertAction(title: "OK", style: .cancel)
        cancelAction.setValue(Colors.purple2, forKey: Keys.titleTextColor)
        
        let alertController = UIAlertController(
            title: "Something went wrong",
            message: "Please try again \nor check Internet connection",
            preferredStyle: .alert
        )
        alertController.addAction(cancelAction)
        
        self.viewController?.present(alertController, animated: true)
    }
    
    func dismissModalView() {
        self.viewController?.dismiss(animated: true)
    }
}
