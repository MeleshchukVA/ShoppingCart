//
//  AppDependency.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 26.10.2022.
//

import Foundation

// MARK: - Class

final class AppDependency {
    
    // MARK: Properties
    let network: NetworkService
    let persistent: PersistentProvider
    
    // MARK: Init
    init(network: NetworkService, persistent: PersistentProvider) {
        self.network = network
        self.persistent = persistent
    }
    
    // MARK: Methods
    static func makeDefault() -> AppDependency {
        let networkService = NetworkService()
        let persistent = PersistentProvider()
        return AppDependency(network: networkService, persistent: persistent)
    }
}

// MARK: - Protocol

protocol HasDependencies {
    var networkService: NetworkServiceProtocol { get }
    var persistentProvider: PersistentProviderProtocol { get }
}

// MARK: - Properties

extension AppDependency: HasDependencies {
    
    var networkService: NetworkServiceProtocol {
        self.network
    }
    
    var persistentProvider: PersistentProviderProtocol {
        self.persistent
    }
}
