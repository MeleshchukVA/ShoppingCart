//
//  CataloguePresenter.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 25.10.2022.
//  
//

import Foundation

// MARK: - Presenter

final class CataloguePresenter {
    
    // MARK: Properties
	weak var viewController: CatalogueViewControllerInput?
    weak var moduleOutput: CatalogueModuleOutput?
    
	private let router: CatalogueRouterInput
	private let interactor: CatalogueInteractorInput
    
    private var isReloading = false
    private var categories: [Categories] = []
    
    // MARK: Init
    
    init(router: CatalogueRouterInput, interactor: CatalogueInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - ModuleInput

extension CataloguePresenter: CatalogueModuleInput {
}

// MARK: - ViewControllerOutput

extension CataloguePresenter: CatalogueViewControllerOutput {
    
    func viewDidLoad() {
        isReloading = true
        interactor.reload()
    }
}

// MARK: - InteractorOutput

extension CataloguePresenter: CatalogueInteractorOutput {
}
