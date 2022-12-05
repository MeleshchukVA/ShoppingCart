//
//  ProductView.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 18.11.2022.
//

import UIKit

// MARK: - ProductView + Appearance

extension ProductView {

    struct Appearance {
        
        let tableViewBackgroundColor = UIColor.black
        let tableViewContentInsetTop: CGFloat = 30.0
    }
}

// MARK: - ProductView class

final class ProductView: BaseView {

    // MARK: Properties
    let appearance: Appearance

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        collectionView.indicatorStyle = .white
        collectionView.backgroundColor = .black
        collectionView.register(ProductCell.self)
        return collectionView
    }()

    // MARK: Init
    init(
        frame: CGRect = .zero,
        appearance: Appearance = Appearance()
    ) {
        self.appearance = appearance
        super.init(frame: frame)
        self.setupView()
        self.setupSubviews()
        self.setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ProductView + ProductViewProtocol

extension ProductView: ProductViewProtocol {

    func updateCollectionViewData(
        delegate: UICollectionViewDelegate,
        dataSource: UICollectionViewDataSource,
        isEmptyCollectionData: Bool
    ) {
        if isEmptyCollectionData {
            collectionView.delegate = delegate
            collectionView.dataSource = dataSource
            collectionView.reloadData()
            collectionView.collectionViewLayout.invalidateLayout()
            collectionView.setEmptyMessage(message: "No products found")
        } else {
            collectionView.restore()
            collectionView.delegate = delegate
            collectionView.dataSource = dataSource
            collectionView.reloadData()
            collectionView.collectionViewLayout.invalidateLayout()
        }
    }

    func invalidateCollectionViewLayout() {
        collectionView.collectionViewLayout.invalidateLayout()
        invalidateIntrinsicContentSize()
    }
}

// MARK: - ProgrammaticallyInitializableViewProtocol

extension ProductView: ProgrammaticallyInitializableViewProtocol {

    func setupView() {
        backgroundColor = .clear
    }

    func setupSubviews() {
        [collectionView, activityIndicator].forEach { addSubview($0) }
    }

    func setupConstraints() {
       [collectionView, activityIndicator].forEach {
           $0.translatesAutoresizingMaskIntoConstraints = false
       }

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
