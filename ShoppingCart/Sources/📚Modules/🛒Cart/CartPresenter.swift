//
//  CartPresenter.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 23.11.2022.
//

import Foundation

final class CartPresenter {
    
    weak var view: CartViewInput?
    weak var moduleOutput: CartModuleOutput?

    private let router: CartRouterInput
    let interactor: CartInteractorInput
    private let tableViewAdapter: CartTableViewAdapterProtocol
    private var products: [CartViewModel] = []

    init(
        router: CartRouterInput,
        interactor: CartInteractorInput,
        tableViewAdapter: CartTableViewAdapterProtocol
    ) {
        self.router = router
        self.interactor = interactor
        self.tableViewAdapter = tableViewAdapter
    }
}

// MARK: - CartModuleInput
extension CartPresenter: CartModuleInput {}

// MARK: - CartViewOutput
extension CartPresenter: CartViewOutput {
    
    func checkoutButtonTapped() {
        if !products.isEmpty {
            router.showCheckoutView(products: products)
        }
    }

    func viewDidLoad() {
        view?.startActivityIndicator()
        interactor.obtainCartProducts()
    }
}

// MARK: - CartInteractorOutput
extension CartPresenter: CartInteractorOutput {
    
    func didObtainCartProducts(products: [ProductCDModel]) {
        let viewModels = products.map { product in
            let procent = (Double(1) + Double(Int(product.discountPercentage)) / Double(100))
            let fullPrice = Double(product.price) * procent
            return CartViewModel(
                id: Int(product.id),
                name: product.title,
                thumbnail: product.thumbnail,
                brand: product.brand,
                price: UInt(product.price),
                fullPrice: UInt(Double(round(100 * fullPrice) / 100)),
                count: UInt(product.count)) { [weak self] id in
                guard let `self` = self,
                      let viewModel = self.products.first(where: { $0.id == id }) else {
                    return
                }
                self.router.showAlertController(viewModel: viewModel)
            } deleteHandler: { [weak self] id in
                guard let `self` = self,
                      let viewModel = self.products.first(where: { $0.id == id }) else {
                    return
                }
                self.deteleItem(viewModel: viewModel)
                self.interactor.obtainCartProducts()
            } updateHandler: { [weak self] value in
                self?.updateCountOfProduct(id: value.0, count: value.1)
            }
        }
        DispatchQueue.main.async {
            if !viewModels.isEmpty {
                self.products = viewModels
                self.tableViewAdapter.restore()
                self.tableViewAdapter.update(viewModels: viewModels)
                self.view?.stopActivityIndicator()
            } else {
                self.tableViewAdapter.setEmptyMessage(message: "Ваша корзина пустая")
                self.tableViewAdapter.update(viewModels: viewModels)
                self.view?.stopActivityIndicator()
            }
        }
    }

    func didObtainCartProduct(product: ProductCDModel) {
        DispatchQueue.main.async {
            for (index, model) in self.products.enumerated() where model.id == product.id {
                self.products[index].count = UInt(product.count)
                break
            }
        }
    }

    private func updateCountOfProduct(id: Int, count: Int) {
        self.interactor.updateCountOfProduct(id: id, count: count)
    }
}

// MARK: - CartTableViewAdapterDelegate
extension CartPresenter: CartTableViewAdapterDelegate {
    
    func deteleItem(viewModel: CartViewModel) {
        let count = interactor.obtainCartProductsCount()
        interactor.deleteProduct(id: viewModel.id)
        self.tableViewAdapter.deleteItem(viewModel)
        if let index = self.products.firstIndex(where: { $0.id == viewModel.id }) {
            self.products.remove(at: index)
        }
        view?.updateTabBarItems(badgeCount: count == 1 ? -1 : count - 1)
        if count == 1 {
            self.tableViewAdapter.setEmptyMessage(message: "Ваша корзина пустая")
        }
    }

    func cartTableViewAdapter(_ adapter: CartTableViewAdapter, didSelectComponentAt indexPath: IndexPath) {
        print(#function)
    }
}
