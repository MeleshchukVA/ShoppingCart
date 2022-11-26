//
//  ImageLoader.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 17.11.2022.
//

import UIKit

// MARK: - ImageLoaderProtocol

protocol ImageLoaderProtocol {
    func loadImage(for stringUrl: String, completion: @escaping (Result<UIImage, ImageLoaderError>) -> Void)
}

// MARK: - ImageLoader class

final class ImageLoader {
    
    private let cache = ImageCache.shared
}

// MARK: - ImageLoader + ImageLoaderProtocol

extension ImageLoader: ImageLoaderProtocol {
    
    // MARK: Properties
    static let shared = ImageLoader()
    
    // MARK: Public methods
    func loadImage(for stringUrl: String, completion: @escaping (Result<UIImage, ImageLoaderError>) -> Void) {
        guard let url = URL(string: stringUrl) else {
            completion(.failure(.badUrl))
            return
        }
        if let imageData = cache[url] {
            DispatchQueue.global(qos: .background).async {
                self.decodeImage(from: imageData, completion: completion)
            }
        } else {
            DispatchQueue.global(qos: .background).async {
                self.downloadImage(from: url, completion: completion)
            }
        }
    }
    
    // MARK: Private methods
    private func downloadImage(from url: URL, completion: @escaping (Result<UIImage, ImageLoaderError>) -> Void) {
        if let data = try? Data(contentsOf: url) {
            decodeImage(from: data) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let image):
                    self.cache[url] = data
                    completion(.success(image))

                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            completion(.failure(.failDownloadImage))
        }
    }

    private func decodeImage(from data: Data, completion: @escaping (Result<UIImage, ImageLoaderError>) -> Void) {
        if let image = UIImage(data: data) {
            completion(.success(image))
        } else {
            completion(.failure(.failToDecodeImage))
        }
    }
}
