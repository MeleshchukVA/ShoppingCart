//
//  CatalogueCell.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 27.10.2022.
//

import UIKit

// MARK: - Class

final class CatalogueCell: UITableViewCell {
    
    // MARK: Properties
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = Font.sber(ofSize: Font.Size.fouthteen, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupView()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extension

extension CatalogueCell {
    
    func fill(viewModel: CatalogueViewModel) {
        label.text = viewModel.name
    }
}

// MARK: - ProgrammaticallyInitializableViewProtocol

extension CatalogueCell: ProgrammaticallyInitializableViewProtocol {
    
    func setupView() {
        if let image = UIImage(systemName: "chevron.right") {
            let accessory = UIImageView(frame: CGRect(
                x: 0,
                y: 0,
                width: image.size.width,
                height: image.size.height
            ))
            
            accessory.image = image
            accessory.tintColor = UIColor.white
            accessoryView = accessory
        }
        
        selectionStyle = .none
        backgroundColor = Colors.cellColor
    }
    
    func setupSubviews() {
        contentView.addSubview(label)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
