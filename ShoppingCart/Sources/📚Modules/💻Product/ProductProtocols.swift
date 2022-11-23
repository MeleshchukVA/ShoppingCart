//
//  ProductProtocols.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 18.11.2022.
//  
//

import UIKit

protocol ProductModuleInput {
    var moduleOutput: ProductModuleOutput? { get }
}

protocol ProductModuleOutput: AnyObject {}

protocol ProductViewInput: ViewInput {
    func updateCollectionViewData(adapter: ProductCollectionViewAdapter, isEmpty: Bool)
}

protocol ProductViewOutput: AnyObject {
    func viewDidLoad()
}

protocol ProductInteractorInput: BaseInteractorInput {
    func reload(category: String)
}

protocol ProductInteractorOutput: AnyObject {
    func didObtainProducts(products: [Products])
}

protocol ProductRouterInput: AnyObject {}
