//
//  CheckoutView.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 24.11.2022.
//

import UIKit

// MARK: - CheckoutView + Appearance

extension CheckoutView {
    
    struct Appearance {
        
        let tableViewBackgroundColor = UIColor.black
        let purpleColor = Colors.purple
        let textCollor = Colors.lightWhite
        let tableViewContentInsetTop: CGFloat = 30.0
        let dismissButtonTrailingInset: CGFloat = -10
        let dismissButtonWidth: CGFloat = 40
        let dismissButtonHeight: CGFloat = 40
        let checkoutButtonHeight: CGFloat = 50.0
        let checkoutButtonVerticalInset: CGFloat = 10.0
        let checkoutButtonSideInset: CGFloat = 10.0
        let checkoutButtonCornerRadius: CGFloat = 10.0
        let closeButton = Localize.Images.xmarkIcon
    }
}

// MARK: - CheckoutView class

final class CheckoutView: BaseView {
    
    // MARK: Properties
    let appearance: Appearance
    let output: CheckoutViewOutput
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CheckoutCell.self)
        tableView.contentInset.top = appearance.tableViewContentInsetTop
        tableView.indicatorStyle = .white
        tableView.separatorStyle = .none
        tableView.separatorColor = Colors.borderLightGray
        return tableView
    }()
    
    private lazy var buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = appearance.textCollor
        button.setTitle("Buy", for: .normal)
        button.layer.cornerRadius = appearance.checkoutButtonCornerRadius
        button.backgroundColor = appearance.purpleColor
        button.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(appearance.closeButton, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: Init
    init(
        frame: CGRect,
        output: CheckoutViewOutput,
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

// MARK: - CheckoutView extension

extension CheckoutView {
    
    // MARK: Public methods
    func hideTableView(isHidden: Bool) {}
    
    func hideCollectionView(isHidden: Bool) {}
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    func startActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    // MARK: Actions
    @objc private func buyButtonTapped() {
        output.buyButtonTapped()
    }
    
    @objc private func dismissButtonTapped() {
        output.dismissButtonTapped()
    }
}

// MARK: - ProgrammaticallyInitializableViewProtocol

extension CheckoutView: ProgrammaticallyInitializableViewProtocol {
    
    func setupView() {
        self.backgroundColor = .black
        self.tableView.backgroundColor = .clear
    }
    
    func setupSubviews() {
        [dismissButton, tableView, activityIndicator, buyButton].forEach { addSubview($0) }
    }
    
    func setupConstraints() {
        [dismissButton, tableView, activityIndicator, buyButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            dismissButton.trailingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                constant: appearance.dismissButtonTrailingInset
            ),
            dismissButton.widthAnchor.constraint(equalToConstant: appearance.dismissButtonWidth),
            dismissButton.heightAnchor.constraint(equalToConstant: appearance.checkoutButtonHeight),
            
            tableView.topAnchor.constraint(equalTo: self.dismissButton.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                constant: -(appearance.checkoutButtonHeight + appearance.checkoutButtonVerticalInset)
            ),
            
            buyButton.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: appearance.checkoutButtonSideInset
            ),
            buyButton.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -appearance.checkoutButtonSideInset
            ),
            buyButton.bottomAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                constant: -appearance.checkoutButtonVerticalInset
            ),
            buyButton.heightAnchor.constraint(equalToConstant: appearance.checkoutButtonHeight),
            
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
