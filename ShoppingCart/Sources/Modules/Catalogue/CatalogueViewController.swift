//
//  CatalogueViewController.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 25.10.2022.
//  
//

import UIKit

// MARK: - ViewController

final class CatalogueViewController: UIViewController {
    
    // MARK: Properties
	private let output: CatalogueViewControllerOutput
    
    // MARK: Init
    init(output: CatalogueViewControllerOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
        
        output.viewDidLoad()
	}
}

// MARK: - ViewControllerInput

extension CatalogueViewController: CatalogueViewControllerInput {
}
