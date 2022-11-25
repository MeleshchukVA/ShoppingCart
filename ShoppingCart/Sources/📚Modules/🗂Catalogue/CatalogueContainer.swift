//
//  CatalogueContainer.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 25.10.2022.
//
//

import UIKit

struct CatalogueContext {
    
    let moduleDependencies: ModuleDependencies
    weak var moduleOutput: CatalogueModuleOutput?
}

final class CatalogueContainer {
    
    weak var router: CatalogueRouterInput?
    let input: CatalogueModuleInput
    let viewController: UIViewController

    static func assemble(with context: CatalogueContext) -> CatalogueContainer {
        let tableViewAdapter = CatalogueTableViewAdapter()
        let collectionViewAdapter = ProductCollectionViewAdapter()
        let router = CatalogueRouter()
        let interactor = CatalogueInteractor(
            networkService: context.moduleDependencies.networkService,
            persistentProvider: context.moduleDependencies.persistentProvider
        )
        let presenter = CataloguePresenter(
            router: router,
            interactor: interactor,
            tableViewAdapter: tableViewAdapter,
            collectionViewAdapter: collectionViewAdapter
        )
        collectionViewAdapter.delegate = presenter
        tableViewAdapter.delegate = presenter
        
        let viewController = CatalogueViewController(output: presenter)

        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput

        interactor.output = presenter
        
        router.viewControllerProvider = { [weak viewController] in
            viewController
        }
        router.navigationControllerProvider = { [weak viewController] in
            viewController?.navigationController
        }
        
        router.moduleDependencies = context.moduleDependencies
        
        if let catalogueView = viewController.catalogueView {
            tableViewAdapter.setupTable(tableView: catalogueView.tableView)
        }
        
        return CatalogueContainer(view: viewController, input: presenter, router: router)
    }

    private init(view: UIViewController, input: CatalogueModuleInput, router: CatalogueRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}
