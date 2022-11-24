//
//  CartViewController.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 23.11.2022.
//

import UIKit

final class CartViewController: BaseViewController {
    
    private let output: CartViewOutput

    lazy var cartView = self.view as? CartView

    init(output: CartViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = CartView(frame: UIScreen.main.bounds, output: output)
        self.view = view
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.viewDidLoad()
    }
}

extension CartViewController: CartViewInput {
    
    func startActivityIndicator() {
        cartView?.activityIndicator.startAnimating()
    }

    func stopActivityIndicator() {
        cartView?.activityIndicator.stopAnimating()
    }
}
