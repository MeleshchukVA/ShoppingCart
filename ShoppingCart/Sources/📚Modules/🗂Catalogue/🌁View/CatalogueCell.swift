//
//  CatalogueCell.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 27.10.2022.
//

import UIKit

final class CatalogueCell: UITableViewCell {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = Font.sber(ofSize: Font.Size.fouthteen, weight: .regular)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.setupView()
        self.setupSubviews()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CatalogueCell {
    
    func fill(viewModel: CatalogueViewModel) {
        label.text = viewModel.name
    }
}

// MARK: - ProgrammaticallyInitializableViewProtocol

extension CatalogueCell: ProgrammaticallyInitializableViewProtocol {
    
    func setupView() {
        if let image = UIImage(named: "chevron.right") {
            let accessory = UIImageView(frame: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
            accessory.image = image
            accessory.tintColor = UIColor.white
            self.accessoryView = accessory
        }
        backgroundColor = Colors.cellColor
    }
    
    func setupSubviews() {
        contentView.addSubview(label)
    }
    
    func setupConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
