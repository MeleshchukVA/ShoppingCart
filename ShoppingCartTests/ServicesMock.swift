//
//  ServicesMock.swift
//  ShoppingCartTests
//
//  Created by Владимир Мелещук on 07.12.2022.
//

import UIKit
@testable import ShoppingCart

// MARK: - ServicesMock

final class ServicesMock: AppDependencyProtocol {
    
    // MARK: Properties
    var networkService: ShoppingCart.NetworkServiceProtocol
    var persistentProvider: ShoppingCart.PersistentProviderProtocol
    
    // MARK: Init
    init(
        networkService: ShoppingCart.NetworkServiceProtocol,
        persistentProvider: ShoppingCart.PersistentProviderProtocol
    ) {
        self.networkService = networkService
        self.persistentProvider = persistentProvider
    }
}

// MARK: - NetworkServiceMock class

final class NetworkServiceMock {
    
    // MARK: Properties
    var resultForGetUsers: Result<ShoppingCart.User, Error>?
    var resultForFetchCategories: Result<ShoppingCart.Categories, Error>?
}

// MARK: - NetworkServiceMock + NetworkServiceProtocol

extension NetworkServiceMock: NetworkServiceProtocol {
    
    func fetchCategories(completion: @escaping (Result<ShoppingCart.Categories, Error>) -> Void) {
        completion(resultForFetchCategories!)
    }
    
    func fetchProducts(with name: String, completion: @escaping (Result<ShoppingCart.Products, Error>) -> Void) {
        return
    }
    
    func fetchSearchedProducts(
        by query: String,
        skip: Int,
        completion: @escaping (Result<ShoppingCart.Products, Error>
        ) -> Void) {
        return
    }
    
    func addCart(_ body: [String: Any], completion: @escaping (Result<ShoppingCart.AddCartResponse, Error>) -> Void) {
        return
    }
    
    func getUser(completion: @escaping (Result<ShoppingCart.User, Error>) -> Void) {
        completion(resultForGetUsers!)
    }
}

// MARK: - PersistentProviderMock class

final class PersistentProviderMock {}

// MARK: - PersistentProviderMock + PersistentProviderProtocol

extension PersistentProviderMock: PersistentProviderProtocol {
    
    func update(
        models: [ShoppingCart.Product],
        action: ShoppingCart.PersistentState,
        completion: @escaping (Result<ShoppingCart.PersistentState, Error>
        ) -> Void) {
        return
    }
    
    func updateCountOfProduct(id: Int, count: Int) -> ShoppingCart.ProductCDModel? {
        return nil
    }
    
    func fetchProducts() -> [ShoppingCart.ProductCDModel] {
        return []
    }
    
    func deleteProduct(id: Int) {
        return
    }
    
    func testPrint(ids: [Int]) {
        return
    }
}

// MARK: - ImageLoaderMock class

final class ImageLoaderMock {
    
    var resultForGetImage: Result<UIImage, ShoppingCart.ImageLoaderError>?
}

// MARK: - ImageLoaderProtocol + ImageLoaderMock
extension ImageLoaderMock: ImageLoaderProtocol {
    
    func loadImage(for stringUrl: String, completion: @escaping (Result<UIImage, ShoppingCart.ImageLoaderError>) -> Void) {
        completion(resultForGetImage!)
    }
}
