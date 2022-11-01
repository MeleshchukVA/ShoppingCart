//
//  CatalogueContainer.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 25.10.2022.
//  
//

import UIKit

// MARK: - CatalogueContext

struct CatalogueContext {
    let moduleDependencies: ModuleDependencies
    weak var moduleOutput: CatalogueModuleOutput?
}

// MARK: - Container

final class CatalogueContainer {
    
    // MARK: Properties
    let input: CatalogueModuleInput
	let viewController: UIViewController
	weak var router: CatalogueRouterInput?
    
    // MARK: Init
    private init(viewController: UIViewController, input: CatalogueModuleInput, router: CatalogueRouterInput) {
        self.viewController = viewController
        self.input = input
        self.router = router
    }
    
    // MARK: Methods
	static func assemble(with context: CatalogueContext) -> CatalogueContainer {
        let tableViewAdapter = CatalogueTableViewAdapter()
        
        let router = CatalogueRouter()
        let interactor = CatalogueInteractor(networkService: context.moduleDependencies.networkService)
        let presenter = CataloguePresenter(
            router: router,
            interactor: interactor,
            tableViewAdapter: tableViewAdapter
        )
		let viewController = CatalogueViewController(output: presenter)
        
        interactor.output = presenter
		presenter.viewController = viewController
		presenter.moduleOutput = context.moduleOutput
        
        if let catalogueView = viewController.catalogueView {
            tableViewAdapter.setupTable(tableView: catalogueView.tableView)
        }

        return CatalogueContainer(viewController: viewController, input: presenter, router: router)
	}
}
