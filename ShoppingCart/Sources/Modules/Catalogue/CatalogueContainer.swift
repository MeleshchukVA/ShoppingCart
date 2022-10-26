//
//  CatalogueContainer.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 25.10.2022.
//  
//

import UIKit

// MARK: - Container

final class CatalogueContainer {
    
    // MARK: Properties
    let input: CatalogueModuleInput
	let viewController: UIViewController
	private(set) weak var router: CatalogueRouterInput?
    
    // MARK: Init
    private init(viewController: UIViewController, input: CatalogueModuleInput, router: CatalogueRouterInput) {
        self.viewController = viewController
        self.input = input
        self.router = router
    }
    
    // MARK: Methods
	static func assemble(with context: CatalogueContext) -> CatalogueContainer {
        let router = CatalogueRouter()
        let interactor = CatalogueInteractor()
        let presenter = CataloguePresenter(router: router, interactor: interactor)
		let viewController = CatalogueViewController(output: presenter)

		presenter.viewController = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return CatalogueContainer(viewController: viewController, input: presenter, router: router)
	}
}

// MARK: - ModuleOutput

struct CatalogueContext {
    let moduleDependencies: ModuleDependencies
	weak var moduleOutput: CatalogueModuleOutput?
}
