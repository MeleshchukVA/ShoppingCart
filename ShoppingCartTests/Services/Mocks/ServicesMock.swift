//
//  ServicesMock.swift
//  ShoppingCartTests
//
//  Created by Владимир Мелещук on 07.12.2022.
//

import UIKit
@testable import ShoppingCart

final class ServicesMock: AppDependencyProtocol {
    
    var networkService: ShoppingCart.NetworkServiceProtocol
    var persistentProvider: ShoppingCart.PersistentProviderProtocol
    
    init(
        networkService: ShoppingCart.NetworkServiceProtocol,
        persistentProvider: ShoppingCart.PersistentProviderProtocol
    ) {
        self.networkService = networkService
        self.persistentProvider = persistentProvider
    }
}
