//
//  CheckoutContainer.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 24.11.2022.
//

import UIKit

// MARK: - CheckoutContext struct
struct CheckoutContext {
    
    let moduleDependencies: ModuleDependencies
    weak var moduleOutput: CheckoutModuleOutput?
}

// MARK: - CheckoutContainer class

final class CheckoutContainer {
    
    // MARK: Properties
    weak var router: CheckoutRouterInput?
    let input: CheckoutModuleInput
    let viewController: UIViewController
    
    // MARK: Init
    private init(view: UIViewController, input: CheckoutModuleInput, router: CheckoutRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
    
    // MARK: Assemble method
    static func assemble(with context: CheckoutContext, products: [CartViewModel]) -> CheckoutContainer {
        let router = CheckoutRouter()
        let tableViewAdapter = CheckoutTableViewAdapter()
        let interactor = CheckoutInteractor(
            networkService: context.moduleDependencies.networkService,
            persistentProvider: context.moduleDependencies.persistentProvider
        )
        let presenter = CheckoutPresenter(
            router: router,
            interactor: interactor,
            products: products,
            tableViewAdapter: tableViewAdapter
        )
        let viewController = CheckoutViewController(output: presenter)
        
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

        if let checkoutView = viewController.checkoutView {
            tableViewAdapter.viewModels = products
            tableViewAdapter.setupTable(tableView: checkoutView.tableView)
        }

        return CheckoutContainer(view: viewController, input: presenter, router: router)
    }
}
