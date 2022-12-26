//
//  ProductViewController.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 18.11.2022.
//
//

import UIKit

// MARK: - ProductViewController class

final class ProductViewController: BaseViewController {
    
    // MARK: Properties
    private let output: ProductViewOutput
    private let viewModel: CatalogueViewModel
    lazy var productView = self.view as? ProductView
    
    // MARK: Init
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
    
    // MARK: Override methods
    override func loadView() {
        let view = ProductView(frame: UIScreen.main.bounds)
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        output.viewDidLoad()
    }
}

// MARK: - ProductViewController private extension

private extension ProductViewController {
    
    func setupNavigationBar() {
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

// MARK: - ProductViewInput

extension ProductViewController: ProductViewInput {
    
    func stopActivityIndicator() {
        productView?.activityIndicator.stopAnimating()
    }

    func startActivityIndicator() {
        productView?.activityIndicator.startAnimating()
    }

    func updateCollectionViewData(adapter: ProductCollectionViewAdapterProtocol, isEmpty: Bool) {
        var adapter = adapter
        guard let delegate = adapter as? UICollectionViewDelegate else { return }
        guard let dataSource = adapter as? UICollectionViewDataSource else { return }
        guard let productView = productView else { return }
        
        adapter.boundsWidth = productView.bounds.width
        
        productView.updateCollectionViewData(
            delegate: delegate,
            dataSource: dataSource,
            isEmptyCollectionData: isEmpty
        )
    }
}
