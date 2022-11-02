//
//  ProductsProtocols.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 02.11.2022.
//  
//

import Foundation

// MARK: - ModuleInput

protocol ProductsModuleInput {
	var moduleOutput: ProductsModuleOutput? { get }
}

// MARK: - ModuleOutput

protocol ProductsModuleOutput: AnyObject {
}

// MARK: - ViewControllerInput

protocol ProductsViewControllerInput: AnyObject {
}

// MARK: - ViewControllerOutput

protocol ProductsViewControllerOutput: AnyObject {
}

// MARK: - InteractorInput

protocol ProductsInteractorInput: AnyObject {
}

// MARK: - InteractorOutput

protocol ProductsInteractorOutput: AnyObject {
}

// MARK: - RouterInput

protocol ProductsRouterInput: AnyObject {
}
