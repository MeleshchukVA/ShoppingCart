//
//  ProfileProtocols.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 24.11.2022.
//

import UIKit

protocol ProfileModuleInput {
    var moduleOutput: ProfileModuleOutput? { get }
}

protocol ProfileModuleOutput: AnyObject {}

protocol ProfileViewInput: AnyObject {
    func setupUser(user: User)
    func setupAvatar(image: UIImage)
    func failToGetUser()
    func failToGetImage()
}

protocol ProfileViewOutput: AnyObject {
    func viewDidLoad()
}

protocol ProfileInteractorInput: AnyObject {
    func getUser()
    func getImage(url: String)
}

protocol ProfileInteractorOutput: AnyObject {
    func didGetUser(user: User)
    func failToGetUser()
    func didGetImage(image: UIImage)
    func failToGetImage()
}

protocol ProfileRouterInput: AnyObject {
    func showError(text: String)
}
