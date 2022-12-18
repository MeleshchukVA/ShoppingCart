//
//  ProfileRouterMock.swift
//  ShoppingCartTests
//
//  Created by Владимир Мелещук on 18.12.2022.
//

import Foundation
@testable import ShoppingCart

final class ProfileRouterMock {
    var text: String?
}

extension ProfileRouterMock: ProfileRouterInput {
    
    func showError(text: String) {
        self.text = text
    }
}
