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
}

// MARK: - ViewControllerOutput

protocol CatalogueViewControllerOutput: AnyObject {
}

// MARK: - InteractorInput

protocol CatalogueInteractorInput: AnyObject {
}

// MARK: - InteractorOutput

protocol CatalogueInteractorOutput: AnyObject {
}

// MARK: - RouterInput

protocol CatalogueRouterInput: AnyObject {
}
