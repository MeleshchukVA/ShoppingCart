//
//  ProfileContainer.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 24.11.2022.
//

import UIKit

struct ProfileContext {
    let moduleDependencies: ModuleDependencies
    weak var moduleOutput: ProfileModuleOutput?
}

final class ProfileContainer {
    let input: ProfileModuleInput
    let viewController: UIViewController
    weak var router: ProfileRouterInput?

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

        return ProfileContainer(view: viewController, input: presenter, router: router)
    }

    private init(view: UIViewController, input: ProfileModuleInput, router: ProfileRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}
