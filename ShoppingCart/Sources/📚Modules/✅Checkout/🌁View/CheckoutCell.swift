//
//  CheckoutCell.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 24.11.2022.
//

import UIKit

extension CheckoutCell {
    
    struct Appearence {
        
        let borderBackgroundColor: CGColor = UIColor(red: 0.259, green: 0.259, blue: 0.267, alpha: 1).cgColor
        let labelFont = Font.sber(ofSize: Font.Size.seventeen, weight: .regular)
        let priceFont = Font.sber(ofSize: Font.Size.seventeen, weight: .bold)
        let priceLabelHeight: CGFloat = 50
        let textCollor = UIColor.white
        let secondaryTextCollor = UIColor.gray
        let verticalInset: CGFloat = 15
        let horizontalInset: CGFloat = 10
        let borderWidth: CGFloat = 0.8
    }
}

final class CheckoutCell: UITableViewCell {
    
    let appearence = Appearence()

    private lazy var lineLayer: CALayer = {
        let layer = CALayer()
        layer.frame = CGRect(
            x: .zero,
            y: contentView.bounds.size.height - appearence.borderWidth,
            width: bounds.size.width,
            height: appearence.borderWidth
        )
        layer.borderWidth = appearence.borderWidth
        layer.borderColor = appearence.borderBackgroundColor
        return layer
    }()

    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = appearence.labelFont
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.lineHeightMultiple = 0.99
        label.attributedText = NSMutableAttributedString(
            string: "mackbook pro",
            attributes: [
                .kern: 0.07,
                .paragraphStyle: paragraphStyle
            ]
        )
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "100$"
        label.font = appearence.priceFont
        label.textColor = appearence.textCollor
        label.textAlignment = .center
        return label
    }()

    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = appearence.labelFont
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.1
        label.attributedText = NSMutableAttributedString(
            string: "Brand: ",
            attributes: [
                .kern: 0.37,
                .paragraphStyle: paragraphStyle
            ]
        )
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

    override func prepareForReuse() {
        super.prepareForReuse()
        [productNameLabel, countLabel, priceLabel].forEach { $0.text = "" }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        lineLayer.removeFromSuperlayer()
        self.layer.insertSublayer(lineLayer, at: 0)
    }
}

extension CheckoutCell {
    
    private func createPrice(
        _ attributedText: inout NSMutableAttributedString,
        _ price: String,
        _ attributedString2: inout NSMutableAttributedString,
        _ fullPrice: String
    ) {
        attributedText = NSMutableAttributedString(string: "\(price) ", attributes: [.foregroundColor: UIColor.white])
        attributedString2 = NSMutableAttributedString(string: fullPrice)
        attributedString2.addAttribute(
            .strikethroughStyle,
            value: NSNumber(value: NSUnderlineStyle.single.rawValue),
            range: NSMakeRange(0, attributedString2.length)
        )
        attributedString2.addAttribute(
            .strikethroughColor,
            value: UIColor.gray,
            range: NSMakeRange(0, attributedString2.length)
        )
        attributedString2.addAttributes(
            [.foregroundColor: UIColor.gray],
            range: NSMakeRange(0, attributedString2.length)
        )
        attributedText.append(attributedString2)
        priceLabel.attributedText = attributedText
    }

    func fill(viewModel: CartViewModel) {
        DispatchQueue.main.async {
            let nameLabelText = NSMutableAttributedString(
                string: "Name: ",
                attributes: [.foregroundColor: self.appearence.secondaryTextCollor]
            )
            let productText = NSMutableAttributedString(
                string: "\(viewModel.name)",
                attributes: [.foregroundColor: self.appearence.textCollor]
            )
            nameLabelText.append(productText)

            let countLabelText = NSMutableAttributedString(
                string: "Count: ",
                attributes: [.foregroundColor: self.appearence.secondaryTextCollor]
            )
            let productCount = NSMutableAttributedString(
                string: "\(viewModel.count)",
                attributes: [.foregroundColor: self.appearence.textCollor]
            )
            countLabelText.append(productCount)

            self.productNameLabel.attributedText = nameLabelText
            self.countLabel.attributedText = countLabelText
            self.priceLabel.text = CurrencyFormatter.shared.string(
                from: Double(viewModel.price * UInt(viewModel.count))
            )
        }
    }
}

// MARK: - ProgrammaticallyInitializableViewProtocol
extension CheckoutCell: ProgrammaticallyInitializableViewProtocol {
    
    func setupView() {
        backgroundColor = Colors.cellColor
    }

    func setupSubviews() {
        [productNameLabel, priceLabel, countLabel].forEach { contentView.addSubview($0) }
    }

    func setupConstraints() {
        productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            productNameLabel.leadingAnchor.constraint(
                equalTo: self.contentView.leadingAnchor,
                constant: appearence.horizontalInset
            ),
            productNameLabel.trailingAnchor.constraint(
                equalTo: priceLabel.leadingAnchor,
                constant: -appearence.horizontalInset / 3
            ),
            productNameLabel.topAnchor.constraint(
                equalTo: self.contentView.topAnchor,
                constant: appearence.verticalInset
            ),
            productNameLabel.heightAnchor.constraint(equalToConstant: appearence.priceLabelHeight / 2),

            countLabel.leadingAnchor.constraint(
                equalTo: self.contentView.leadingAnchor,
                constant: appearence.horizontalInset
            ),
            countLabel.topAnchor.constraint(
                equalTo: self.productNameLabel.bottomAnchor,
                constant: appearence.verticalInset / 2
            ),
            countLabel.heightAnchor.constraint(equalToConstant: appearence.priceLabelHeight / 2),

            priceLabel.trailingAnchor.constraint(
                equalTo: self.contentView.trailingAnchor,
                constant: -appearence.horizontalInset
            ),
            priceLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: appearence.verticalInset),
            priceLabel.heightAnchor.constraint(equalToConstant: appearence.priceLabelHeight)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
