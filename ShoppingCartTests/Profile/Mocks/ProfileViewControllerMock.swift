//
//  ProfileViewControllerMock.swift
//  ShoppingCartTests
//
//  Created by Владимир Мелещук on 18.12.2022.
//

import UIKit
@testable import ShoppingCart

final class ProfileViewControllerMock {
    var user: ShoppingCart.User?
    var isFalseActivityIndicator = false
    var isFalseToGetImage = false
}

extension ProfileViewControllerMock: ProfileViewInput {
    
    func setupUser(user: ShoppingCart.User) {
        self.user = user
    }
    
    func setupAvatar(image: UIImage) {
        
    }
    
    func failToGetUser() {
        isFalseActivityIndicator = true
    }
    
    func failToGetImage() {
        isFalseToGetImage = true
    }
}
