//
//  ProductsPresenter.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 02.11.2022.
//  
//

import Foundation

// MARK: - Presenter

final class ProductsPresenter {
    
    // MARK: Properties
	weak var viewController: ProductsViewControllerInput?
    weak var moduleOutput: ProductsModuleOutput?
    
	private let router: ProductsRouterInput
	private let interactor: ProductsInteractorInput
    
    // MARK: Init
    
    init(router: ProductsRouterInput, interactor: ProductsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - ModuleInput

extension ProductsPresenter: ProductsModuleInput {
}

// MARK: - ViewControllerOutput

extension ProductsPresenter: ProductsViewControllerOutput {
}

// MARK: - InteractorOutput

extension ProductsPresenter: ProductsInteractorOutput {
}
