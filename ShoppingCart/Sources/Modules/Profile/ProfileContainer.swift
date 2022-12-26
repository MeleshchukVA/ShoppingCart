//
//  ProfileContainer.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 24.11.2022.
//

import UIKit

// MARK: - ProfileContext struct

struct ProfileContext {
    
    let moduleDependencies: ModuleDependencies
    weak var moduleOutput: ProfileModuleOutput?
}

// MARK: - ProfileContainer class

final class ProfileContainer {
    
    // MARK: Properties
    
    let input: ProfileModuleInput
    let viewController: UIViewController
    weak var router: ProfileRouterInput?
    
    // MARK: Init
    private init(view: UIViewController, input: ProfileModuleInput, router: ProfileRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
    
    // MARK: Assemble method
    static func assemble(with context: ProfileContext) -> ProfileContainer {
        let router = ProfileRouter()
        let interactor = ProfileInteractor(
            imageLoader: ImageLoader.shared,
            networkService: context.moduleDependencies.networkService
        )
        let presenter = ProfilePresenter(router: router, interactor: interactor)
        let viewController = ProfileViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput

        interactor.output = presenter
        
        router.viewControllerProvider = { [weak viewController] in
            viewController
        }
        router.navigationControllerProvider = { [weak viewController] in
            viewController?.navigationController
        }
        router.moduleDependencies = context.moduleDependencies

        return ProfileContainer(view: viewController, input: presenter, router: router)
    }
}
