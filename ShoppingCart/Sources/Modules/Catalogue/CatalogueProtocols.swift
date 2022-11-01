//
//  CatalogueProtocols.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 25.10.2022.
//  
//

import Foundation

// MARK: - ModuleInput

protocol CatalogueModuleInput {
	var moduleOutput: CatalogueModuleOutput? { get }
}

// MARK: - ModuleOutput

protocol CatalogueModuleOutput: AnyObject {
}

// MARK: - ViewControllerInput

protocol CatalogueViewControllerInput: AnyObject {
    func startActivityIndicator()
    func stopActivityIndicator()
}

// MARK: - ViewControllerOutput

protocol CatalogueViewControllerOutput: AnyObject {
    func viewDidLoad()
}

// MARK: - InteractorInput

protocol CatalogueInteractorInput: AnyObject {
    func reload()
}

// MARK: - InteractorOutput

protocol CatalogueInteractorOutput: AnyObject {
    func didObtainCategories(categories: Categories)
}

// MARK: - RouterInput

protocol CatalogueRouterInput: AnyObject {
}
