//
//  CheckoutView.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 24.11.2022.
//

import UIKit

extension CheckoutView {
    struct Appearance {
        let tableViewBackgroundColor = UIColor.black
        let purpleColor = Colors.purple
        let textCollor = Colors.lightWhite
        let tableViewContentInsetTop: CGFloat = 30.0
        let checkoutButtonHeight: CGFloat = 50.0
        let checkoutButtonVerticalInset: CGFloat = 10.0
        let checkoutButtonSideInset: CGFloat = 10.0
        let checkoutButtonCornerRadius: CGFloat = 10.0
    }
}

final class CheckoutView: BaseView {
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
    @objc private func buyButtonTapped() {
        output.buyButtonTapped()
    }
}

// MARK: - Public
extension CheckoutView {
    func hideTableView(isHidden: Bool) {}
    
    func hideCollectionView(isHidden: Bool) {}
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    func startActivityIndicator() {
        activityIndicator.startAnimating()
    }
}

// MARK: - ProgrammaticallyInitializableViewProtocol
extension CheckoutView: ProgrammaticallyInitializableViewProtocol {
    func setupView() {
        self.backgroundColor = .black
        self.tableView.backgroundColor = .clear
        if #available(iOS 13.0, *) {
            self.largeContentTitle = "Your order"
        } else {
            //
        }
    }
    
    func setupSubviews() {
        [tableView, activityIndicator, buyButton].forEach { addSubview($0) }
    }
    
    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.bottomAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                constant: -(appearance.checkoutButtonHeight + appearance.checkoutButtonVerticalInset)
            ),
            
            buyButton.bottomAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                constant: -appearance.checkoutButtonVerticalInset
            ),
            buyButton.heightAnchor.constraint(equalToConstant: appearance.checkoutButtonHeight),
            buyButton.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: appearance.checkoutButtonSideInset
            ),
            buyButton.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -appearance.checkoutButtonSideInset
            ),
            
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
