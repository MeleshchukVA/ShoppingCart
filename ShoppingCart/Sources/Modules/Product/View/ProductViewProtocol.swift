//
//  ProductViewProtocol.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 18.11.2022.
//

import UIKit

protocol ProductViewProtocol: AnyObject {
    func updateCollectionViewData(
        delegate: UICollectionViewDelegate,
        dataSource: UICollectionViewDataSource,
        isEmptyCollectionData: Bool
    )
}
