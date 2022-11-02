//
//  ProductsContainer.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 02.11.2022.
//  
//

import UIKit

// MARK: - Container

final class ProductsContainer {
    
    // MARK: Properties
    let input: ProductsModuleInput
	let viewController: UIViewController
	weak var router: ProductsRouterInput?
    
    // MARK: Init
    private init(viewController: UIViewController, input: ProductsModuleInput, router: ProductsRouterInput) {
        self.viewController = viewController
        self.input = input
        self.router = router
    }
    
    // MARK: Methods
	static func assemble(with context: ProductsContext) -> ProductsContainer {
        let router = ProductsRouter()
        let interactor = ProductsInteractor()
        let presenter = ProductsPresenter(router: router, interactor: interactor)
        let viewController = ProductsViewController(output: presenter)

        interactor.output = presenter

		presenter.viewController = viewController
		presenter.moduleOutput = context.moduleOutput

        return ProductsContainer(viewController: viewController, input: presenter, router: router)
	}
}

// MARK: - ModuleOutput

struct ProductsContext {
	weak var moduleOutput: ProductsModuleOutput?
}
