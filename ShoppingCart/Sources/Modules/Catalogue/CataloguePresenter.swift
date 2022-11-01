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
    private let tableViewAdapter: CatalogueTableViewAdapterProtocol
    
    // MARK: Init
    
    init(
        router: CatalogueRouterInput,
        interactor: CatalogueInteractorInput,
        tableViewAdapter: CatalogueTableViewAdapterProtocol
    ) {
        self.router = router
        self.interactor = interactor
        self.tableViewAdapter = tableViewAdapter
    }
}

// MARK: - ViewControllerOutput

extension CataloguePresenter: CatalogueViewControllerOutput {
    
    func viewDidLoad() {
        viewController?.startActivityIndicator()
        interactor.reload()
    }
}

// MARK: - ModuleInput

extension CataloguePresenter: CatalogueModuleInput {
}

// MARK: - InteractorOutput

extension CataloguePresenter: CatalogueInteractorOutput {
    
    func didObtainCategories(categories: Categories) {
        let viewModels = categories.map {
            CatalogueViewModel(id: UUID(), name: $0.capitalized)
        }
        
        DispatchQueue.main.async {
            if viewModels.isEmpty {
                self.tableViewAdapter.setEmptyMessage(
                    message: "Не найдено категорий или подключитесь к сети, чтобы загрузить данные"
                )
                self.viewController?.stopActivityIndicator()
            } else {
                self.tableViewAdapter.restore()
                self.tableViewAdapter.update(viewModels: viewModels)
                self.viewController?.stopActivityIndicator()
            }
        }
    }
}
