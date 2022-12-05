//
//  CatalogueView.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 31.10.2022.
//

import UIKit

// MARK: - CatalogueView + Appearance

extension CatalogueView {
    
    struct Appearance {
        
        let tableViewBackgroundColor = UIColor.black
        let tableViewContentInsetTop: CGFloat = 30.0
    }
}

// MARK: - CatalogueView class

final class CatalogueView: BaseView {
    
    // MARK: Properties
    let appearance: Appearance
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.keyboardDismissMode = .onDrag
        tableView.indicatorStyle = .white
        if #available(iOS 13.0, *) {
            tableView.contentInset.top = appearance.tableViewContentInsetTop
        }
        tableView.register(CatalogueCell.self)
        return tableView
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        collectionView.keyboardDismissMode = .onDrag
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

// MARK: - CatalogueView extension

extension CatalogueView {
    
    func hideTableView(isHidden: Bool) {
        tableView.isHidden = isHidden
    }
    
    func hideCollectionView(isHidden: Bool) {
        collectionView.isHidden = isHidden
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    func startActivityIndicator() {
        activityIndicator.startAnimating()
    }
}

// MARK: - ProgrammaticallyInitializableViewProtocol

extension CatalogueView: ProgrammaticallyInitializableViewProtocol {
    
    func setupView() {
        tableView.backgroundColor = appearance.tableViewBackgroundColor
        collectionView.isHidden = true
    }
    
    func setupSubviews() {
        [tableView, collectionView, activityIndicator].forEach { addSubview($0) }
    }
    
    func setupConstraints() {
        [tableView, collectionView, activityIndicator].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
                
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}

// MARK: - ProductViewProtocol

extension CatalogueView: ProductViewProtocol {
    
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
