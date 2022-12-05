//
//  CartView.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 23.11.2022.
//

import UIKit

// MARK: - CartView + Appearance

extension CartView {
    
    struct Appearance {
        
        let tableViewBackgroundColor = UIColor.black
        let purpleColor = Colors.purple
        let textCollor = Colors.lightWhite
        let tableViewContentInsetTop: CGFloat = 30.0
        let checkoutButtonHeight: CGFloat = 50
        let checkoutButtonVerticalInset: CGFloat = 10
        let checkoutButtonSideInset: CGFloat = 10
        let checkoutButtonCornerRadius: CGFloat = 10
    }
}

// MARK: - CartView class

final class CartView: BaseView {
    
    // MARK: Properties
    private let output: CartViewOutput
    let appearance: Appearance

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.indicatorStyle = .white
        if #available(iOS 13.0, *) {
            tableView.contentInset.top = appearance.tableViewContentInsetTop
        } else {
            tableView.contentInset = UIEdgeInsets.zero
        }
        tableView.register(CartCell.self)
        return tableView
    }()

    private lazy var checkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = appearance.textCollor
        button.setTitle("Checkout", for: .normal)
        button.layer.cornerRadius = appearance.checkoutButtonCornerRadius
        button.backgroundColor = appearance.purpleColor
        button.addTarget(self, action: #selector(checkoutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: Init
    init(
        frame: CGRect = .zero,
        output: CartViewOutput,
        appearance: Appearance = Appearance()
    ) {
        self.appearance = appearance
        self.output = output
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

// MARK: - CartView extension

extension CartView {
    
    // MARK: Actions
    @objc private func checkoutButtonTapped() {
        output.checkoutButtonTapped()
    }
}

// MARK: - ProgrammaticallyInitializableViewProtocol

extension CartView: ProgrammaticallyInitializableViewProtocol {
    
    func setupView() {
        tableView.backgroundColor = appearance.tableViewBackgroundColor
    }

    func setupSubviews() {
        [tableView, activityIndicator, checkoutButton].forEach { addSubview($0) }
    }

    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        checkoutButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                constant: -(appearance.checkoutButtonHeight + appearance.checkoutButtonVerticalInset)
            ),

            checkoutButton.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: appearance.checkoutButtonSideInset
            ),
            checkoutButton.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -appearance.checkoutButtonSideInset
            ),
            checkoutButton.bottomAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                constant: -appearance.checkoutButtonVerticalInset
            ),
            checkoutButton.heightAnchor.constraint(
                equalToConstant: appearance.checkoutButtonHeight
            ),

            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
