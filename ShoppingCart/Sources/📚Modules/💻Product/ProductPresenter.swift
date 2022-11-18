//
//  ProductPresenter.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 18.11.2022.
//  
//

import Foundation

// MARK: - Presenter

final class ProductPresenter {
    
    // MARK: Properties
	weak var viewController: ProductViewControllerInput?
    weak var moduleOutput: ProductModuleOutput?
    
	private let router: ProductRouterInput
	private let interactor: ProductInteractorInput
    
    // MARK: Init
    
    init(router: ProductRouterInput, interactor: ProductInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - ModuleInput

extension ProductPresenter: ProductModuleInput {
}

// MARK: - ViewControllerOutput

extension ProductPresenter: ProductViewControllerOutput {
}

// MARK: - InteractorOutput

extension ProductPresenter: ProductInteractorOutput {
}
