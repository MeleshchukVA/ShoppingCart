//
//  CartTableViewAdapter.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 23.11.2022.
//

import UIKit

protocol CartTableViewAdapterDelegate: AnyObject {
    func cartTableViewAdapter(
        _ adapter: CartTableViewAdapter,
        didSelectComponentAt indexPath: IndexPath
    )
    func deteleItem(viewModel: CartViewModel)
}

protocol CartTableViewAdapterProtocol {
    func setupTable(tableView: UITableView)
    func update(viewModels: [CartViewModel])
    func update(by id: Int, count: Int)
    func setEmptyMessage(message: String)
    func deleteItem(_ item: CartViewModel)
    func restore()
}

final class CartTableViewAdapter: NSObject {

    weak var delegate: CartTableViewAdapterDelegate?
    private weak var tableView: UITableView?
    var viewModels = [CartViewModel]()
}

// MARK: - CartTableViewAdapterProtocol
extension CartTableViewAdapter: CartTableViewAdapterProtocol {
    
    func setupTable(tableView: UITableView) {
        self.tableView = tableView
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
    }

    func update(viewModels: [CartViewModel]) {
        guard self.viewModels != viewModels else { return }
        self.viewModels = viewModels
        self.tableView?.reloadData()
    }

    func update(by id: Int, count: Int) {
        for (index, model) in self.viewModels.enumerated() where model.id == id {
            self.viewModels[index].count = UInt(count)
            break
        }
    }

    func deleteItem(_ item: CartViewModel) {
        guard let index = viewModels.firstIndex(where: { $0.id == item.id }) else { return }
        viewModels.remove(at: index)
        self.tableView?.deleteSections(IndexSet(integer: index), with: .fade)
    }

    func setEmptyMessage(message: String) {
        self.tableView?.setEmptyMessage(message: message)
    }

    func restore() {
        self.tableView?.restore()
    }
}

// MARK: - UITableViewDataSource
extension CartTableViewAdapter: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModels.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(cellType: CartCell.self, for: indexPath)
        if viewModels.indices.contains(indexPath.section) {
            cell.fill(viewModel: viewModels[indexPath.section])
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CartTableViewAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        197
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.cartTableViewAdapter(self, didSelectComponentAt: indexPath)
    }
}
