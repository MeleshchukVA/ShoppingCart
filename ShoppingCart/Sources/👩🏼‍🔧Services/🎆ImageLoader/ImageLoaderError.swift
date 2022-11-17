//
//  ImageLoaderError.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 17.11.2022.
//

import Foundation

enum ImageLoaderError {
    case badUrl
    case failDownloadImage
    case failToDecodeImage
}

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
