//
//  ProfileRouter.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 24.11.2022.
//

import UIKit

// MARK: - ProfileRouter class

final class ProfileRouter: BaseRouter {}

// MARK: - ProfileRouterInput

extension ProfileRouter: ProfileRouterInput {
    
    func showError(text: String) {
        let cancelAction = UIAlertAction(title: "OK", style: .cancel)
        cancelAction.setValue(Colors.purple2, forKey: "titleTextColor")
        let alertController = UIAlertController(title: "Fail", message: text, preferredStyle: .alert)
        alertController.addAction(cancelAction)
        self.viewController?.present(alertController, animated: true)
    }
}
