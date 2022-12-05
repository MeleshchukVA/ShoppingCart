//
//  ReuseIdentifier.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 27.10.2022.
//

import UIKit

// MARK: - ReuseIdentifiable Protocol

protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

// MARK: - ReuseIdentifiable Extension

extension ReuseIdentifiable {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

// MARK: - Class + ReuseIdentifiable

extension UICollectionReusableView: ReuseIdentifiable {}

extension UITableViewCell: ReuseIdentifiable {}

extension UITableViewHeaderFooterView: ReuseIdentifiable {}

// MARK: - UICollectionView

extension UICollectionView {
    
    // MARK: UICollectionViewCell
    func register<T: UICollectionViewCell>(_ cellType: T.Type) {
        self.register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    func dequeueCell<T: UICollectionViewCell>(cellType: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(
            withReuseIdentifier: T.reuseIdentifier,
            for: indexPath
        ) as? T else {
            fatalError("Can't dequeue UICollectionViewCell")
        }
        return cell
    }
    
    // MARK: UICollectionReusableView
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
            withReuseIdentifier: T.reuseIdentifier,
            for: indexPath
        ) as? T else {
            fatalError("Can't dequeue UICollectionReusableView")
        }
        return cell
    }
}

// MARK: - UITableView

extension UITableView {
    
    // MARK: UITableViewCell
    func register<T: UITableViewCell>(_ cellType: T.Type) {
        self.register(cellType, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    func dequeueCell<T: UITableViewCell>(cellType: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(
            withIdentifier: T.reuseIdentifier,
            for: indexPath
        ) as? T else {
            fatalError("Can't dequeue UITableViewCell")
        }
        return cell
    }
    
    // MARK: UITableViewHeaderFooterView
    func register<T: UITableViewHeaderFooterView>(_ cellType: T.Type) {
        self.register(cellType, forHeaderFooterViewReuseIdentifier: cellType.reuseIdentifier)
    }

    func dequeueHeaderFooterViewCell<T: UITableViewHeaderFooterView>(cellType: T.Type) -> T {
        guard let cell = self.dequeueReusableHeaderFooterView(
            withIdentifier: T.reuseIdentifier
        ) as? T else {
            fatalError("Can't dequeue UITableViewHeaderFooterView")
        }
        return cell
    }
}
