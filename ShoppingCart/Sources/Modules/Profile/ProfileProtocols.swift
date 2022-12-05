//
//  ProfileProtocols.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 24.11.2022.
//

import UIKit

// MARK: - ProfileModuleInput

protocol ProfileModuleInput {
    var moduleOutput: ProfileModuleOutput? { get }
}

// MARK: - ProfileModuleOutput

protocol ProfileModuleOutput: AnyObject {}

// MARK: - ProfileViewInput

protocol ProfileViewInput: AnyObject {
    func setupUser(user: User)
    func setupAvatar(image: UIImage)
    func failToGetUser()
    func failToGetImage()
}

// MARK: - ProfileViewOutput

protocol ProfileViewOutput: AnyObject {
    func viewDidLoad()
}

// MARK: - ProfileInteractorInput

protocol ProfileInteractorInput: AnyObject {
    func getUser()
    func getImage(url: String)
}

// MARK: - ProfileInteractorOutput

protocol ProfileInteractorOutput: AnyObject {
    func didGetUser(user: User)
    func failToGetUser()
    func didGetImage(image: UIImage)
    func failToGetImage()
}

// MARK: - ProfileRouterInput

protocol ProfileRouterInput: AnyObject {
    func showError(text: String)
}
