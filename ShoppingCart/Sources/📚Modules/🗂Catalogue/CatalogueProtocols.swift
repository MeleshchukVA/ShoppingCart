//
//  CatalogueProtocols.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 25.10.2022.
//
//

import Foundation

// MARK: - CatalogueModuleInput

protocol CatalogueModuleInput {
    var moduleOutput: CatalogueModuleOutput? { get }
}

// MARK: - CatalogueModuleOutput

protocol CatalogueModuleOutput: AnyObject {}

// MARK: - CatalogueViewInput

protocol CatalogueViewInput: ViewInput {
    func hideTableView(isHidden: Bool)
    func hideCollectionView()
    func updateCollectionViewData(adapter: ProductCollectionViewAdapter, isEmpty: Bool)
}

// MARK: - CatalogueViewOutput

protocol CatalogueViewOutput: AnyObject {
    func viewDidLoad()
    func viewDidAppear()
    func searchBarTextDidEndEditing(with query: String)
    func searchBarCancelButtonClicked()
}

// MARK: - CatalogueInteractorInput

protocol CatalogueInteractorInput: BaseInteractorInput {
    func reload()
    func reload(by query: String, skip: Int)
    func obtainCartProducts()
    func obtainCartProductsCount() -> Int
}

// MARK: - CatalogueInteractorOutput

protocol CatalogueInteractorOutput: AnyObject {
    func didObtainCategories(categories: Categories)
    func didObtainDBProducts(products: [ProductCDModel])
    func didObtainProducts(products: [Products])
}

// MARK: - CatalogueRouterInput

protocol CatalogueRouterInput: AnyObject {
    func showDetail(with viewModel: CatalogueViewModel)
}
