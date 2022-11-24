//
//  CheckoutRouter.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 24.11.2022.
//

import UIKit

final class CheckoutRouter: BaseRouter {}

extension CheckoutRouter: CheckoutRouterInput {
    func showSuccessAddCartAlert() {
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel)
        cancelAction.setValue(Colors.purple2, forKey: "titleTextColor")
        let alertController = UIAlertController(
            title: "Success",
            message: "Your order send!",
            preferredStyle: .alert
        )
        alertController.addAction(cancelAction)
        self.viewController?.present(alertController, animated: true)
    }
    
    func showErrorAddCartAlert() {
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel)
        cancelAction.setValue(Colors.purple2, forKey: "titleTextColor")
        let alertController = UIAlertController(
            title: "Fail",
            message: "Something went wrong...",
            preferredStyle: .alert
        )
        alertController.addAction(cancelAction)
        self.viewController?.present(alertController, animated: true)
    }
}
