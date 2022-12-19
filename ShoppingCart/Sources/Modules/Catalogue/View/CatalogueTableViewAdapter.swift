//
//  CatalogueTableViewAdapter.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 31.10.2022.
//

import UIKit

// MARK: - CatalogueTableViewAdapterDelegate

protocol CatalogueTableViewAdapterDelegate: AnyObject {
    func catalogueTableViewAdapter(
        _ adapter: CatalogueTableViewAdapter,
        didSelectComponentAt indexPath: IndexPath
    )
}

// MARK: - CatalogueTableViewAdapterProtocol

protocol CatalogueTableViewAdapterProtocol {
    func setupTable(tableView: UITableView)
    func update(viewModels: [CatalogueViewModel])
    func setEmptyMessage(message: String)
    func restore()
}

// MARK: - CatalogueTableViewAdapter class

final class CatalogueTableViewAdapter: NSObject {
    
    weak var delegate: CatalogueTableViewAdapterDelegate?
    private(set) weak var tableView: UITableView?
    var viewModels = [CatalogueViewModel]()
}

// MARK: - CatalogueTableViewAdapter + CatalogueTableViewAdapterProtocol

extension CatalogueTableViewAdapter: CatalogueTableViewAdapterProtocol {
    
    func setupTable(tableView: UITableView) {
        self.tableView = tableView
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
    }
    
    func update(viewModels: [CatalogueViewModel]) {
        self.viewModels = viewModels
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
    
    func setEmptyMessage(message: String) {
        DispatchQueue.main.async {
            self.tableView?.setEmptyMessage(message: message)
        }
    }
    
    func restore() {
        DispatchQueue.main.async {
            self.tableView?.restore()
        }
    }
}

// MARK: - UITableViewDataSource

extension CatalogueTableViewAdapter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(cellType: CatalogueCell.self, for: indexPath)
        if viewModels.indices.contains(indexPath.row) {
            cell.fill(viewModel: viewModels[indexPath.row])
        }
        return cell
    }
}
// MARK: - UITableViewDelegate

extension CatalogueTableViewAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        49
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.catalogueTableViewAdapter(self, didSelectComponentAt: indexPath)
    }
}
