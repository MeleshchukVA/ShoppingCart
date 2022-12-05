//
//  CartContainer.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 23.11.2022.
//

import UIKit

// MARK: - CartContext struct

struct CartContext {
    
    let moduleDependencies: ModuleDependencies
    weak var moduleOutput: CartModuleOutput?
}

// MARK: - CartContainer class

final class CartContainer {
    
    // MARK: Properties
    let input: CartModuleInput
    let viewController: UIViewController
    weak var router: CartRouterInput?
    
    // MARK: Init
    private init(view: UIViewController, input: CartModuleInput, router: CartRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
    
    // MARK: Assemble method
    static func assemble(with context: CartContext) -> CartContainer {
        let router = CartRouter()
        let tableViewAdapter = CartTableViewAdapter()
        let interactor = CartInteractor(
            networkService: context.moduleDependencies.networkService,
            persistentProvider: context.moduleDependencies.persistentProvider
        )
        let presenter = CartPresenter(
            router: router,
            interactor: interactor,
            tableViewAdapter: tableViewAdapter
        )
        let viewController = CartViewController(output: presenter)

        tableViewAdapter.delegate = presenter
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

        if let cartView = viewController.cartView {
            tableViewAdapter.setupTable(tableView: cartView.tableView)
        }

        return CartContainer(view: viewController, input: presenter, router: router)
    }
}
