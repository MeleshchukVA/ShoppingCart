//
//  ProductContainer.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 18.11.2022.
//
//

import UIKit

// MARK: - ProductContext struct

struct ProductContext {
    
    let moduleDependencies: ModuleDependencies
    weak var moduleOutput: ProductModuleOutput?
}

// MARK: - ProductContainer class

final class ProductContainer {
    
    // MARK: Properties
    let input: ProductModuleInput
    let viewController: UIViewController
    weak var router: ProductRouterInput?
    
    // MARK: Init
    private init(view: UIViewController, input: ProductModuleInput, router: ProductRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
    
    // MARK: Assemble method
    static func assemble(with context: ProductContext, viewModel: CatalogueViewModel) -> ProductContainer {
        let collectionViewAdapter = ProductCollectionViewAdapter()
        let router = ProductRouter()
        let interactor = ProductInteractor(
            networkService: context.moduleDependencies.networkService,
            persistentProvider: context.moduleDependencies.persistentProvider
        )
        let presenter = ProductPresenter(
            router: router,
            interactor: interactor,
            collectionViewAdapter: collectionViewAdapter,
            viewModel: viewModel
        )
        collectionViewAdapter.delegate = presenter

        let viewController = ProductViewController(output: presenter, viewModel: viewModel)

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

        return ProductContainer(view: viewController, input: presenter, router: router)
    }
}
