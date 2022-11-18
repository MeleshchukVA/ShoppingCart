//
//  ProductContainer.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 18.11.2022.
//  
//

import UIKit

// MARK: - Container

final class ProductContainer {
    
    // MARK: Properties
    let input: ProductModuleInput
	let viewController: UIViewController
	weak var router: ProductRouterInput?
    
    // MARK: Init
    private init(viewController: UIViewController, input: ProductModuleInput, router: ProductRouterInput) {
        self.viewController = viewController
        self.input = input
        self.router = router
    }
    
    // MARK: Methods
	static func assemble(with context: ProductContext) -> ProductContainer {
        let router = ProductRouter()
        let interactor = ProductInteractor()
        let presenter = ProductPresenter(router: router, interactor: interactor)
        let viewController = ProductViewController(output: presenter)

        interactor.output = presenter

		presenter.viewController = viewController
		presenter.moduleOutput = context.moduleOutput

        return ProductContainer(viewController: viewController, input: presenter, router: router)
	}
}

// MARK: - ModuleOutput

struct ProductContext {
	weak var moduleOutput: ProductModuleOutput?
}
