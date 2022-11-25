//
//  ImageCache.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 17.11.2022.
//

import Foundation

// MARK: - ImageCacheProtocol

protocol ImageCacheProtocol {
    subscript(_ url: URL) -> Data? { get set }
}

// MARK: - ImageCache

final class ImageCache {
    
    static let shared = ImageCache()

    private lazy var cache: LRUCache<NSURL, Data> = {
        let cache = LRUCache<NSURL, Data>()
        cache.countLimit = 30
        cache.totalCostLimit = 1024 * 1024 * 256
        return cache
    }()
}

// MARK: - ImageCache + ImageCacheProtocol

extension ImageCache: ImageCacheProtocol {
    
    subscript(url: URL) -> Data? {
        get {
            cache.value(forKey: url as NSURL)
        }
        set {
            cache.setValue(newValue, forKey: url as NSURL)
        }
    }
}
