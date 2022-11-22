//
//  ProductCollectionViewAdapter.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 18.11.2022.
//

import UIKit

// MARK: - ProductCollectionViewAdapterDelegate

protocol ProductCollectionViewAdapterDelegate: AnyObject {
    func productCollectionViewAdapter(
        _ adapter: ProductCollectionViewAdapter,
        didSelectComponentAt indexPath: IndexPath
    )
    func willDisplay(at index: Int)
}

extension ProductCollectionViewAdapterDelegate {
    
    func productCollectionViewAdapter(
        _ adapter: ProductCollectionViewAdapter,
        didSelectComponentAt indexPath: IndexPath
    ) {}
    func willDisplay(at index: Int) {}
}

// MARK: - Class

final class ProductCollectionViewAdapter: NSObject {
    
    // MARK: Properties
    weak var delegate: ProductCollectionViewAdapterDelegate?
    var viewModels: [ProductViewModel] = []
    var boundsWidth: CGFloat = 0
}

// MARK: - UICollectionViewDataSource

extension ProductCollectionViewAdapter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let viewModel = viewModels[indexPath.row]
        let cell = collectionView.dequeueCell(cellType: ProductCell.self, for: indexPath)
        cell.fill(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.productCollectionViewAdapter(
            self,
            didSelectComponentAt: indexPath
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            UIView.animate(
                withDuration: 1,
                delay: .zero,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 0.5,
                options: .curveEaseOut
            ) {
                cell.transform = CGAffineTransform(scaleX: 0.87, y: 0.87)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            UIView.animate(
                withDuration: 0.7,
                delay: .zero,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 0.5,
                options: .curveEaseIn
            ) {
                cell.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProductCollectionViewAdapter: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = itemWidth(for: self.boundsWidth, spacing: ProductConstants.Layout.spacing)
        return CGSize(width: width, height: width + ProductConstants.Layout.heightProductCard)
    }
    
    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let totalSpacing: CGFloat =
        (ProductConstants.Layout.itemsInRow * ProductConstants.Layout.spacingLeft
        + (ProductConstants.Layout.itemsInRow - 1) * ProductConstants.Layout.spacingRight)
        + ProductConstants.Layout.minimumInteritemSpacingForSectionAt - ProductConstants.Layout.spacing
        let finalWidth = (width - totalSpacing) / ProductConstants.Layout.itemsInRow
        return floor(finalWidth)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(
            top: ProductConstants.Layout.spacingTop,
            left: ProductConstants.Layout.spacingLeft,
            bottom: ProductConstants.Layout.spacingBottom,
            right: ProductConstants.Layout.spacingRight
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        ProductConstants.Layout.spacingBottom
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        ProductConstants.Layout.minimumInteritemSpacingForSectionAt
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        delegate?.willDisplay(at: indexPath.item)
    }
}
