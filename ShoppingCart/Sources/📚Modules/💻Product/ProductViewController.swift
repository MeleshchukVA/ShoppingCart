//
//  ProductViewController.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 18.11.2022.
//  
//

import UIKit

// MARK: - ViewController

final class ProductViewController: UIViewController {
    
    // MARK: Properties
	private let output: ProductViewControllerOutput
    
    // MARK: Init
    init(output: ProductViewControllerOutput) {
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

extension ProductViewController: ProductViewControllerInput {
}
