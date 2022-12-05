//
//  CatalogueCell.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 27.10.2022.
//

import UIKit

// MARK: - Appearance

extension CatalogueCell {
    
    struct Appearance {
        
        let chevronImage = Localize.Images.chevronImage
        let cellColor = Colors.cellColor
        let labelLeadingInset: CGFloat = 20
    }
}

// MARK: - CatalogueCell class

final class CatalogueCell: UITableViewCell {
    
    // MARK: Properties
    let appearance = Appearance()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = Font.sber(ofSize: Font.Size.fouthteen, weight: .regular)
        return label
    }()
    
    // MARK: Init
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

// MARK: - CatalogueCell extension

extension CatalogueCell {
    
    func fill(viewModel: CatalogueViewModel) {
        label.text = viewModel.name
    }
}

// MARK: - ProgrammaticallyInitializableViewProtocol

extension CatalogueCell: ProgrammaticallyInitializableViewProtocol {
    
    func setupView() {
        if let image = appearance.chevronImage {
            let accessory = UIImageView(
                frame: CGRect(
                    x: 0,
                    y: 0,
                    width: image.size.width,
                    height: image.size.height)
            )
            accessory.image = image
            accessory.tintColor = UIColor.white
            self.accessoryView = accessory
        }
        backgroundColor = appearance.cellColor
    }
    
    func setupSubviews() {
        contentView.addSubview(label)
    }
    
    func setupConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: appearance.labelLeadingInset),
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
