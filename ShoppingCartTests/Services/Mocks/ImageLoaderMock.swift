//
//  ImageLoaderMock.swift
//  ShoppingCartTests
//
//  Created by Владимир Мелещук on 08.01.2023.
//

import UIKit
@testable import ShoppingCart

final class ImageLoaderMock {
    
    var resultForGetImage: Result<UIImage, ShoppingCart.ImageLoaderError>?
}

extension ImageLoaderMock: ImageLoaderProtocol {
    
    func loadImage(for stringUrl: String, completion: @escaping (Result<UIImage, ShoppingCart.ImageLoaderError>) -> Void) {
        completion(resultForGetImage!)
    }
}
