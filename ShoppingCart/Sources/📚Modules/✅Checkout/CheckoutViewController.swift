//
//  CheckoutViewController.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 24.11.2022.
//

import UIKit

final class CheckoutViewController: UIViewController {
    
    private let output: CheckoutViewOutput

    lazy var checkoutView = self.view as? CheckoutView

    init(output: CheckoutViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = CheckoutView(frame: UIScreen.main.bounds, output: output)
        self.view = view
    }
}

extension CheckoutViewController: CheckoutViewInput {}
