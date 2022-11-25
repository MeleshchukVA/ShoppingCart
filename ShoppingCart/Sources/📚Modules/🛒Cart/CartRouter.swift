//
//  CartRouter.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 23.11.2022.
//

import UIKit

// MARK: - CartRouter class

final class CartRouter: BaseRouter {}

// MARK: - CartRouter extension

extension CartRouter {
    
    private func openShare(shareFiles: [Any]) {
        let activityViewController = UIActivityViewController(activityItems: shareFiles, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.viewController?.view
        self.viewController?.present(activityViewController, animated: true, completion: nil)
    }
}

// MARK: - CartRouterInput

extension CartRouter: CartRouterInput {
    
    func showAlertController(viewModel: CartViewModel) {
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        cancelAction.setValue(Colors.purple2, forKey: "titleTextColor")

        let shareAction = UIAlertAction(title: "Share", style: .default) { [weak self] _ in
            let shareFiles: [Any] = [viewModel.name]
            self?.openShare(shareFiles: shareFiles)
        }
        shareAction.setValue(Colors.purple2, forKey: "titleTextColor")

        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            viewModel.deleteHandler(viewModel.id)
        }

        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        [cancelAction, shareAction, deleteAction].forEach { alertController.addAction($0) }

        self.viewController?.present(alertController, animated: true)
    }

    func showCheckoutView(products: [CartViewModel]) {
        guard let moduleDependencies = moduleDependencies else { return }
        let context = CheckoutContext(moduleDependencies: moduleDependencies)
        let container = CheckoutContainer.assemble(with: context, products: products)
        navigationController?.present(container.viewController, animated: true)
    }
}
