//
//  ProductProtocols.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 18.11.2022.
//
//

import UIKit

// MARK: - ProductModuleInput

protocol ProductModuleInput {
    var moduleOutput: ProductModuleOutput? { get }
}

// MARK: - ProductModuleOutput

protocol ProductModuleOutput: AnyObject {}

// MARK: - ProductViewInput

protocol ProductViewInput: ViewInput {
    func updateCollectionViewData(adapter: ProductCollectionViewAdapter, isEmpty: Bool)
}

// MARK: - ProductViewOutput

protocol ProductViewOutput: AnyObject {
    func viewDidLoad()
}

// MARK: - ProductInteractorInput

protocol ProductInteractorInput: BaseInteractorInput {
    func reload(category: String)
}

// MARK: - ProductInteractorOutput

protocol ProductInteractorOutput: AnyObject {
    func didObtainProducts(products: [Products])
}

// MARK: - ProductRouterInput

protocol ProductRouterInput: AnyObject {}
