//
//  ProductsCollectionViewAdapter.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 17.11.2022.
//

import UIKit

protocol ProductsCollectionViewAdapterDelegate: AnyObject {
    func productsCollectionViewAdapter(
        _ adapter: ProductsCollectionViewAdapter,
        didSelectComponentAt indexPath: IndexPath
    )
    func willDisplay(at index: Int)
}

extension ProductsCollectionViewAdapterDelegate {
    func willDisplay(at index: Int) {}
    func productCollectionViewAdapter(
        _ adapter: ProductsCollectionViewAdapter,
        didSelectComponentAt indexPath: IndexPath
    ) {}
}

final class ProductsCollectionViewAdapter: NSObject {
    weak var delegate: ProductsCollectionViewAdapterDelegate?
    var viewModels: [ProductsViewModel] = []
    var boundsWidth: CGFloat = 0
}

// MARK: - UICollectionViewDataSource

extension ProductsCollectionViewAdapter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = viewModels[indexPath.row]
        let cell = collectionView.dequeueCell(cellType: ProductsCell.self, for: indexPath)
        cell.fill(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.productsCollectionViewAdapter(
            self,
            didSelectComponentAt: indexPath
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            UIView.animate(withDuration: 1,
                           delay: .zero,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0.5,
                           options: .curveEaseOut) {
                cell.transform = CGAffineTransform(scaleX: 0.87, y: 0.87)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            UIView.animate(
                withDuration: 0.7,
                delay: .zero, usingSpringWithDamping: 1,
                initialSpringVelocity: 0.5,
                options: .curveEaseIn) {
                    cell.transform = CGAffineTransform(scaleX: 1, y: 1)
                }
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProductsCollectionViewAdapter: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = itemWidth(for: self.boundsWidth, spacing: ProductsConstants.Layout.spacing)
        return CGSize(width: width, height: width + ProductsConstants.Layout.heightProductCard)
    }
    
    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        
        let totalSpacing: CGFloat = (
            ProductsConstants.Layout.itemsInRow *
            ProductsConstants.Layout.spacingLeft +
            (ProductsConstants.Layout.itemsInRow - 1) *
            ProductsConstants.Layout.spacingRight) +
            ProductsConstants.Layout.minimumInteritemSpacingForSectionAt -
            ProductsConstants.Layout.spacing
        let finalWidth = (width - totalSpacing) / ProductsConstants.Layout.itemsInRow
        return floor(finalWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(
            top: ProductsConstants.Layout.spacingTop,
            left: ProductsConstants.Layout.spacingLeft,
            bottom: ProductsConstants.Layout.spacingBottom,
            right: ProductsConstants.Layout.spacingRight
        )
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        ProductsConstants.Layout.spacingBottom
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        ProductsConstants.Layout.minimumInteritemSpacingForSectionAt
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        delegate?.willDisplay(at: indexPath.item)
    }
}
