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
    
    func setEmptyMessage(message: String) {
        let messageLabel = UILabel(frame: CGRect(
            x: 0,
            y: 0,
            width: UIScreen.main.bounds.size.width,
            height: UIScreen.main.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .gray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = Font.sber(ofSize: Font.Size.twentyEight, weight: .regular)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
