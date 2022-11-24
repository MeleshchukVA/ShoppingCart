//
//  ProfilePresenter.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 24.11.2022.
//

import UIKit

final class ProfilePresenter {
    weak var view: ProfileViewInput?
    weak var moduleOutput: ProfileModuleOutput?
    
    private let router: ProfileRouterInput
    private let interactor: ProfileInteractorInput
    
    init(router: ProfileRouterInput, interactor: ProfileInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ProfilePresenter: ProfileModuleInput {}

extension ProfilePresenter: ProfileViewOutput {
    func viewDidLoad() {
        interactor.getUser()
    }
}

extension ProfilePresenter: ProfileInteractorOutput {
    func didGetImage(image: UIImage) {
        DispatchQueue.main.async {
            self.view?.setupAvatar(image: image)
        }
    }
    
    func failToGetImage() {
        DispatchQueue.main.async {
            self.view?.failToGetImage()
        }
    }
    
    func didGetUser(user: User) {
        DispatchQueue.main.async {
            self.view?.setupUser(user: user)
        }
    }
    
    func failToGetUser() {
        DispatchQueue.main.async {
            self.router.showError(text: "Fail to get user...")
            self.view?.failToGetUser()
        }
    }
}
