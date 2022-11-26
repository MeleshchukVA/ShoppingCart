//
//  CataloguePresenter.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 25.10.2022.
//
//

import Foundation

// MARK: - CataloguePresenter

final class CataloguePresenter {
    
    // MARK: Properties
    weak var view: CatalogueViewInput?
    weak var moduleOutput: CatalogueModuleOutput?
    
    private let router: CatalogueRouterInput
    let interactor: CatalogueInteractorInput
    private let tableViewAdapter: CatalogueTableViewAdapterProtocol
    private var collectionViewAdapter: ProductCollectionViewAdapter
    private var categories: [CatalogueViewModel] = []
    private var products: [Product] = []
    private var total: Int = 0
    private var query: String = ""
    
    // MARK: Init
    init(
        router: CatalogueRouterInput,
        interactor: CatalogueInteractorInput,
        tableViewAdapter: CatalogueTableViewAdapterProtocol,
        collectionViewAdapter: ProductCollectionViewAdapter
    ) {
        self.router = router
        self.interactor = interactor
        self.tableViewAdapter = tableViewAdapter
        self.collectionViewAdapter = collectionViewAdapter
    }
}

// MARK: - CataloguePresenter private extension

private extension CataloguePresenter {
    
    func clear() {
        query = ""
        total = 0
        categories.removeAll()
        products.removeAll()
    }
}

// MARK: - CatalogueModuleInput

extension CataloguePresenter: CatalogueModuleInput {}

// MARK: - CatalogueViewOutput

extension CataloguePresenter: CatalogueViewOutput {
    
    func viewDidLoad() {
        view?.startActivityIndicator()
        interactor.reload()
    }
    
    func viewDidAppear() {
        interactor.obtainCartProducts()
    }
    
    func searchBarTextDidEndEditing(with query: String) {
        self.clear()
        view?.startActivityIndicator()
        view?.hideTableView(isHidden: true)
        self.query = query
        interactor.reload(by: query, skip: 0)
    }
    
    func searchBarCancelButtonClicked() {
        if !products.isEmpty || !query.isEmpty {
            self.clear()
            view?.startActivityIndicator()
            view?.hideCollectionView()
            interactor.reload()
        }
    }
}

// MARK: - CatalogueInteractorOutput

extension CataloguePresenter: CatalogueInteractorOutput {
    
    func didObtainCategories(categories: Categories) {
        let viewModels = categories.map {
            CatalogueViewModel(id: UUID(), name: $0.capitalized.replacingOccurrences(of: "-", with: " "))
        }.sorted { $0.name < $1.name }
        
        DispatchQueue.main.async {
            if !viewModels.isEmpty {
                self.view?.hideTableView(isHidden: false)
                self.categories = viewModels
                self.tableViewAdapter.restore()
                self.tableViewAdapter.update(viewModels: viewModels)
                self.view?.stopActivityIndicator()
            } else {
                self.view?.hideTableView(isHidden: false)
                self.tableViewAdapter.setEmptyMessage(
                    message: "No categories found or connect to a network to download data"
                )
                self.view?.stopActivityIndicator()
            }
        }
    }
    
    func didObtainDBProducts(products: [ProductCDModel]) {
        if !products.isEmpty {
            self.view?.updateTabBarItems(badgeCount: products.count)
        }
    }
    
    func didObtainProducts(products: [Products]) {
        guard let product = products.first else { return }
        self.total = product.total
        if self.products.isEmpty {
            self.products = product.results
        } else {
            self.products.append(contentsOf: product.results)
        }
        let viewModels = self.products.map { product in
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
                guard let `self` = self,
                      let product = self.products.first(where: { $0.id == id }) else {
                    return
                }
                self.interactor.addToCart(products: [product]) { [weak self] state in
                    guard let `self` = self else { return }
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

// MARK: - CatalogueTableViewAdapterDelegate

extension CataloguePresenter: CatalogueTableViewAdapterDelegate {
    
    func catalogueTableViewAdapter(_ adapter: CatalogueTableViewAdapter, didSelectComponentAt indexPath: IndexPath) {
        let category = self.categories[indexPath.row]
        router.showDetail(with: category)
    }
}

// MARK: - ProductCollectionViewAdapterDelegate

extension CataloguePresenter: ProductCollectionViewAdapterDelegate {
    
    func willDisplay(at index: Int) {
        guard index == (products.count - 1), index >= 9, products.count != total, total != 0 else {
            return
        }
        if !self.query.isEmpty, products.count < total {
            interactor.reload(by: self.query, skip: index + 1)
        }
    }
}
