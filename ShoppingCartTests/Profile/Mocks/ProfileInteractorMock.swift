//
//  ProfileInteractorMock.swift
//  ShoppingCartTests
//
//  Created by Владимир Мелещук on 18.12.2022.
//

import Foundation
@testable import ShoppingCart

final class ProfileInteractorMock {
    var networkServiceMock: NetworkServiceMock?
    var output: ProfileInteractorOutput?
    var imageLoaderMock: ImageLoaderMock?
}

extension ProfileInteractorMock: ProfileInteractorInput {
    
    func getImage(url: String) {
        imageLoaderMock?.loadImage(for: url, completion: { result in
            switch result {
            case .success(let image):
                self.output?.didGetImage(image: image)
            case .failure:
                self.output?.failToGetImage()
            }
        })
    }
    
    func getUser() {
        networkServiceMock?.getUser(completion: { result in
            switch result {
            case .success(let user):
                self.output?.didGetUser(user: user)
                self.getImage(url: user.image)
            case .failure:
                self.output?.failToGetUser()
            }
        })
    }
}
