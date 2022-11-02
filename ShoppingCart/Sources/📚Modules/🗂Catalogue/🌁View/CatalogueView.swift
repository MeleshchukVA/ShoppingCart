//
//  CatalogueView.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 31.10.2022.
//

import UIKit

// MARK: - Appearance

extension CatalogueView {
    
    struct Appearance {
        let tableViewBackgroundColor = UIColor.black
        let tableViewContentInsetTop: CGFloat = 30.0
    }
}

// MARK: - Class

final class CatalogueView: BaseView {
    
    // MARK: Properties
    let appearance: Appearance
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.keyboardDismissMode = .onDrag
        tableView.indicatorStyle = .white
        tableView.contentInset.top = appearance.tableViewContentInsetTop
        tableView.register(CatalogueCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: Init
    init(
        frame: CGRect = .zero,
        appearance: Appearance = Appearance()
    ) {
        self.appearance = appearance
        super.init(frame: frame)
        
        setupView()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ProgrammaticallyInitializableViewProtocol

extension CatalogueView: ProgrammaticallyInitializableViewProtocol {
    
    func setupView() {
        tableView.backgroundColor = appearance.tableViewBackgroundColor
    }
    
    func setupSubviews() {
        [tableView, activityIndicator].forEach { addSubview($0) }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
