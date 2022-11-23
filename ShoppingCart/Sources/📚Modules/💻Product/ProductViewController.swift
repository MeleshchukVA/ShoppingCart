//
//  ProductViewController.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 18.11.2022.
//  
//

import UIKit

final class ProductViewController: BaseViewController {
    private let output: ProductViewOutput
    private let viewModel: CatalogueViewModel
    lazy var productView = self.view as? ProductView
    
    init(
        output: ProductViewOutput,
        viewModel: CatalogueViewModel
    ) {
        self.output = output
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = ProductView(frame: UIScreen.main.bounds)
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        output.viewDidLoad()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
        navigationItem.largeTitleDisplayMode = .never
        title = viewModel.name
    }
}

extension ProductViewController: ProductViewInput {
    func stopActivityIndicator() {
        productView?.activityIndicator.stopAnimating()
    }
    
    func startActivityIndicator() {
        productView?.activityIndicator.startAnimating()
    }
    
    func updateCollectionViewData(adapter: ProductCollectionViewAdapter, isEmpty: Bool) {
        guard let productView = productView else { return }
        adapter.boundsWidth = productView.bounds.width
        productView.updateCollectionViewData(
            delegate: adapter,
            dataSource: adapter,
            isEmptyCollectionData: isEmpty
        )
    }
}
