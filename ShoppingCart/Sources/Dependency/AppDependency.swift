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
    let networkService: NetworkService
    
    // MARK: Init
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    // MARK: Methods
    static func makeDefault() -> AppDependency {
        let networkService = NetworkService()
        return AppDependency(networkService: networkService)
    }
}

// MARK: - Protocol

protocol HasDependencies {
    var network: NetworkServiceProtocol { get }
}

// MARK: - Properties

extension AppDependency: HasDependencies {
    
    var network: NetworkServiceProtocol {
        self.networkService
    }
}
