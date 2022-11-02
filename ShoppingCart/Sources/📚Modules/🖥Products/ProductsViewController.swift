//
//  ProductsViewController.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 02.11.2022.
//  
//

import UIKit

// MARK: - ViewController

final class ProductsViewController: UIViewController {
    
    // MARK: Properties
	private let output: ProductsViewControllerOutput
    
    // MARK: Init
    init(output: ProductsViewControllerOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

// MARK: - ViewControllerInput

extension ProductsViewController: ProductsViewControllerInput {
}
