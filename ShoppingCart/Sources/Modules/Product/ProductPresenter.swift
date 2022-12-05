//
//  ProductPresenter.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 18.11.2022.
//
//

import Foundation

// MARK: - ProductPresenter class

final class ProductPresenter {
    
    // MARK: Properties
    weak var view: ProductViewInput?
    weak var moduleOutput: ProductModuleOutput?

    private let router: ProductRouterInput
    let interactor: ProductInteractorInput
    private var collectionViewAdapter: ProductCollectionViewAdapter
    private let viewModel: CatalogueViewModel
    private var products: [Product] = []
    
    // MARK: Init
    init(
        router: ProductRouterInput,
        interactor: ProductInteractorInput,
        collectionViewAdapter: ProductCollectionViewAdapter,
        viewModel: CatalogueViewModel
    ) {
        self.router = router
        self.interactor = interactor
        self.collectionViewAdapter = collectionViewAdapter
        self.viewModel = viewModel
    }
}

// MARK: - ProductModuleInput

extension ProductPresenter: ProductModuleInput {}

// MARK: - ProductViewOutput

extension ProductPresenter: ProductViewOutput {
    
    func viewDidLoad() {
        view?.startActivityIndicator()
        interactor.reload(category: viewModel.name.lowercased())
    }
}

// MARK: - ProductInteractorOutput

extension ProductPresenter: ProductInteractorOutput {
    
    func didObtainProducts(products: [Products]) {
        guard let product = products.first else { return }
        self.products = product.products
        let viewModels = product.products.map { product in
            ProductViewModel(
                id: product.id,
                title: product.title,
                description: product.productDescription,
                price: UInt(product.price),
                discountPercentage: product.discountPercentage,
                rating: product.rating,
                stock: product.stock,
                brand: product.brand.lowercased(),
                category: product.category,
                thumbnail: product.thumbnail,
                images: product.images
            ) { [weak self] id in
                guard let self = self,
                      let product = self.products.first(where: { $0.id == id }) else {
                    return
                }
                self.interactor.addToCart(products: [product]) { [weak self] state in
                    guard let self = self else { return }
                    switch state {
                    case .add:
                        DispatchQueue.main.async {
                            let productsInCart = self.interactor.obtainCartProductsCount()
                            self.view?.updateTabBarItems(badgeCount: productsInCart + 1)
                        }

                    case .remove:
                        break

                    case .update:
                        break
                    }
                }
            }
        }
        
        DispatchQueue.main.async {
            self.collectionViewAdapter.viewModels = viewModels
            self.view?.updateCollectionViewData(adapter: self.collectionViewAdapter, isEmpty: viewModels.isEmpty)
            self.view?.stopActivityIndicator()
        }
    }
}

// MARK: - ProductCollectionViewAdapterDelegate

extension ProductPresenter: ProductCollectionViewAdapterDelegate {
    
    func productCollectionViewAdapter(
        _ adapter: ProductCollectionViewAdapter,
        didSelectComponentAt indexPath: IndexPath
    ) {}
}
