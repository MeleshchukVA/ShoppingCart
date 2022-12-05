//
//  ImageLoaderError.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 17.11.2022.
//

import Foundation

// MARK: - ImageLoaderError enum

enum ImageLoaderError {
    
    case badUrl
    case failDownloadImage
    case failToDecodeImage
}

// MARK: - ImageLoaderError + LocalizedError

extension ImageLoaderError: LocalizedError {
    
    private var errorDescription: String {
        switch self {
        case .badUrl:
            return "Bad URL!"
            
        case .failDownloadImage:
            return "Fail to download image!"
            
        case .failToDecodeImage:
            return "Fail to decode image from data!"
        }
    }
}
