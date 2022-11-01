//
//  UICollectionView + Extension.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 27.10.2022.
//

import UIKit

extension UICollectionReusableView: ReuseIdentifiable {}

extension UICollectionView {
    
    // MARK: CollectionViewCell
    func register<T: UICollectionViewCell>(_ cellType: T.Type) {
        self.register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    func dequeueCell<T: UICollectionViewCell>(cellType: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(
            withReuseIdentifier: T.reuseIdentifier,
            for: indexPath
        ) as? T else {
            fatalError("can't dequeue")
        }
        
        return cell
    }
    
    // MARK: CollectionReusableView
    func register<T: UICollectionReusableView>(_ cellType: T.Type) {
        self.register(
            T.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: T.reuseIdentifier
        )
    }
    
    func dequeueSectionHeaderCell<T: UICollectionReusableView>(cellType: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: T.reuseIdentifier, for: indexPath
        ) as? T else {
            fatalError("can't dequeue")
        }
        
        return cell
    }
}
