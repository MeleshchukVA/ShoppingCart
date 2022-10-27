//
//  UITableView + Extension.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 27.10.2022.
//

import UIKit

extension UITableViewCell: ReuseIdentifiable {}

extension UITableViewHeaderFooterView: ReuseIdentifiable {}

extension UITableView {
    
    // MARK: TableViewCell
    func dequeueCell<T: UITableViewCell>(cellType: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(
            withIdentifier: T.reuseIdentifier,
            for: indexPath
        ) as? T else {
            fatalError("can't dequeue")
        }
        
        return cell
    }
    
    func register<T: UITableViewCell>(_ cellType: T.Type) {
        self.register(
            cellType,
            forCellReuseIdentifier: cellType.reuseIdentifier
        )
    }
    
    // MARK: TableViewHeaderFooterView
    func register<T: UITableViewHeaderFooterView>(_ cellType: T.Type) {
        self.register(
            cellType,
            forHeaderFooterViewReuseIdentifier: cellType.reuseIdentifier
        )
    }
    
    func dequeueHeaderFooterViewCell<T: UITableViewHeaderFooterView>(cellType: T.Type) -> T {
        guard let cell = self.dequeueReusableHeaderFooterView(
            withIdentifier: T.reuseIdentifier
        ) as? T else {
            fatalError("can't dequeue")
        }
        
        return cell
    }
    
    // MARK: SetEmptyMessage
    func setEmptyMessage(message: String) {
        let messageLabel = UILabel(
            frame: CGRect(
                x: 0,
                y: 0,
                width: UIScreen.main.bounds.size.width,
                height: UIScreen.main.bounds.size.height
            )
        )
        
        messageLabel.text = message
        messageLabel.textColor = .gray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = Font.sber(ofSize: Font.Size.twentyEight, weight: .regular)
        messageLabel.sizeToFit()
    
        self.backgroundView = messageLabel
    }
    
    // MARK: Restore
    func restore() {
        self.backgroundView = nil
    }
}
