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
    
    // MARK: Init
    init(network: NetworkService) {
        self.network = network
    }
    
    // MARK: Methods
    static func makeDefault() -> AppDependency {
        let networkService = NetworkService()
        return AppDependency(network: networkService)
    }
}

// MARK: - Protocol

protocol HasDependencies {
    var networkService: NetworkServiceProtocol { get }
}

// MARK: - Properties

extension AppDependency: HasDependencies {
    
    var networkService: NetworkServiceProtocol {
        self.network
    }
}
