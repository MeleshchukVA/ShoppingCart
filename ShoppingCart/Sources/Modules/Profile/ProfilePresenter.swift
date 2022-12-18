//
//  ProfilePresenter.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 24.11.2022.
//

import UIKit

// MARK: - ProfilePresenter class

final class ProfilePresenter {
    
    // MARK: Properties
    weak var view: ProfileViewInput?
    weak var moduleOutput: ProfileModuleOutput?
    
    private let router: ProfileRouterInput
    private let interactor: ProfileInteractorInput
    
    // MARK: Init
    init(router: ProfileRouterInput, interactor: ProfileInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - ProfileModuleInput

extension ProfilePresenter: ProfileModuleInput {}

// MARK: - ProfileViewOutput

extension ProfilePresenter: ProfileViewOutput {
    
    func viewDidLoad() {
        interactor.getUser()
    }
}

// MARK: - ProfileInteractorOutput

extension ProfilePresenter: ProfileInteractorOutput {
    
    func didGetImage(image: UIImage) {
        self.view?.setupAvatar(image: image)
    }
    
    func failToGetImage() {
        self.view?.failToGetImage()
    }
    
    func didGetUser(user: User) {
        self.view?.setupUser(user: user)
    }
    
    func failToGetUser() {
        self.router.showError(text: "Fail to get user...")
        self.view?.failToGetUser()
    }
}
