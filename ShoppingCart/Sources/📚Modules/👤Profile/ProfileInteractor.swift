//
//  ProfileInteractor.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 24.11.2022.
//
import Foundation

final class ProfileInteractor {
    
    weak var output: ProfileInteractorOutput?
    private let imageLoader: ImageLoaderProtocol
    private let networkService: NetworkServiceProtocol

    init(
        imageLoader: ImageLoaderProtocol,
        networkService: NetworkServiceProtocol
    ) {
        self.imageLoader = imageLoader
        self.networkService = networkService
    }
}

extension ProfileInteractor: ProfileInteractorInput {
    
    func getImage(url: String) {
        imageLoader.loadImage(for: url) { [weak self] result in
            switch result {
            case .success(let image):
                self?.output?.didGetImage(image: image)

            case .failure:
                self?.output?.failToGetImage()
            }
        }
    }

    func getUser() {
        networkService.getUser { [weak self] result in
            switch result {
            case .success(let user):
                self?.output?.didGetUser(user: user)
                self?.getImage(url: user.image)

            case .failure:
                self?.output?.failToGetUser()
            }
        }
    }
}
