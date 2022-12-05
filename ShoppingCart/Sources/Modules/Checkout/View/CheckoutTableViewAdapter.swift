//
//  CheckoutTableViewAdapter.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 24.11.2022.
//

import UIKit

// MARK: - CheckoutTableViewAdapterProtocol

protocol CheckoutTableViewAdapterProtocol {
    func setupTable(tableView: UITableView)
}

// MARK: - CheckoutTableViewAdapter class

final class CheckoutTableViewAdapter: NSObject {
    
    private weak var tableView: UITableView?
    var viewModels = [CartViewModel]()
}

// MARK: - CheckoutTableViewAdapter + CheckoutTableViewAdapterProtocol

extension CheckoutTableViewAdapter: CheckoutTableViewAdapterProtocol {
    
    func setupTable(tableView: UITableView) {
        self.tableView = tableView
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
    }
}

// MARK: - UITableViewDelegate

extension CheckoutTableViewAdapter: UITableViewDelegate {}

// MARK: - UITableViewDataSource

extension CheckoutTableViewAdapter: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(cellType: CheckoutCell.self, for: indexPath)
        if viewModels.indices.contains(indexPath.row) {
            cell.fill(viewModel: viewModels[indexPath.row])
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Your order"
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.font = Font.sber(ofSize: Font.Size.twentyEight, weight: .bold)
        header.textLabel?.textAlignment = .center
    }
}
