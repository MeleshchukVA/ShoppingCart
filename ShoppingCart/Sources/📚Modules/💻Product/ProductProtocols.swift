//
//  ProductProtocols.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 18.11.2022.
//  
//

import Foundation

// MARK: - ModuleInput

protocol ProductModuleInput {
	var moduleOutput: ProductModuleOutput? { get }
}

// MARK: - ModuleOutput

protocol ProductModuleOutput: AnyObject {
}

// MARK: - ViewControllerInput

protocol ProductViewControllerInput: AnyObject {
}

// MARK: - ViewControllerOutput

protocol ProductViewControllerOutput: AnyObject {
}

// MARK: - InteractorInput

protocol ProductInteractorInput: AnyObject {
}

// MARK: - InteractorOutput

protocol ProductInteractorOutput: AnyObject {
}

// MARK: - RouterInput

protocol ProductRouterInput: AnyObject {
}
