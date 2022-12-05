//
//  CatalogueRouter.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 25.10.2022.
//
//

import UIKit

// MARK: - CatalogueRouter class

final class CatalogueRouter: BaseRouter {}

// MARK: - CatalogueRouterInput

extension CatalogueRouter: CatalogueRouterInput {
    
    func showDetail(with viewModel: CatalogueViewModel) {
        guard let moduleDependencies = moduleDependencies else { return }
        let context = ProductContext(moduleDependencies: moduleDependencies, moduleOutput: self)
        let container = ProductContainer.assemble(with: context, viewModel: viewModel)
        navigationController?.pushViewController(container.viewController, animated: true)
    }
}

// MARK: - ProductModuleOutput

extension CatalogueRouter: ProductModuleOutput {}
