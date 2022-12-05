//
//  AppDependency.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 26.10.2022.
//

import Foundation

// MARK: - AppDependency class

final class AppDependency {

    // MARK: Properties
    let network: NetworkService
    let persistent: PersistentProvider

    // MARK: Init
    init(network: NetworkService, persistent: PersistentProvider) {
        self.network = network
        self.persistent = persistent
    }

    // MARK: Public methods
    static func makeDefault() -> AppDependency {
        let network = NetworkService()
        let persistent = PersistentProvider()
        return AppDependency(network: network, persistent: persistent)
    }
}

// MARK: - AppDependencyProtocol

protocol AppDependencyProtocol {
    var networkService: NetworkServiceProtocol { get }
    var persistentProvider: PersistentProviderProtocol { get }
}

// MARK: - AppDependency + AppDependencyProtocol

extension AppDependency: AppDependencyProtocol {

    var networkService: NetworkServiceProtocol {
        self.network
    }

    var persistentProvider: PersistentProviderProtocol {
        self.persistent
    }
}
