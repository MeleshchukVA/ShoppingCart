//
//  CatalogueProtocols.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 25.10.2022.
//  
//

import Foundation

protocol CatalogueModuleInput {
    var moduleOutput: CatalogueModuleOutput? { get }
}

protocol CatalogueModuleOutput: AnyObject {}

protocol CatalogueViewInput: ViewInput {
    func hideTableView(isHidden: Bool)
    func hideCollectionView()
    func updateCollectionViewData(adapter: ProductCollectionViewAdapter, isEmpty: Bool)
}

protocol CatalogueViewOutput: AnyObject {
    func viewDidLoad()
    func viewDidAppear()
    func searchBarTextDidEndEditing(with query: String)
    func searchBarCancelButtonClicked()
}

protocol CatalogueInteractorInput: BaseInteractorInput {
    func reload()
    func reload(by query: String, skip: Int)
    func obtainCartProducts()
    func obtainCartProductsCount() -> Int
}

protocol CatalogueInteractorOutput: AnyObject {
    func didObtainCategories(categories: Categories)
    func didObtainDBProducts(products: [ProductCDModel])
    func didObtainProducts(products: [Products])
}

protocol CatalogueRouterInput: AnyObject {
    func showDetail(with viewModel: CatalogueViewModel)
}
