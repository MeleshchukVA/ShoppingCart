//
//  CartCell.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 23.11.2022.
//

import UIKit

extension CartCell {
    
    struct Appearance {
        
        let borderBackgroundColor: CGColor = UIColor(red: 0.259, green: 0.259, blue: 0.267, alpha: 1).cgColor

        let borderWidth: CGFloat = 0.8
        let layerOffset: CGFloat = 55.0

        let whiteColor = Colors.lightWhite
        let purpleColor = Colors.purple2

        let photoIcon = Localize.Images.photo
        let minusIconGray = Localize.Images.minusIcon
        let plusIcon = Localize.Images.plusIcon
        let elipsisIcon = Localize.Images.ellipsisIcon
        let cardButtonImagePlus = Localize.Images.cartPlusIcon
        let cardButtonImageMinus = Localize.Images.cartMinusIcon
    }
}

final class CartCell: UITableViewCell {
    
    private let imageLoader: ImageLoaderProtocol = ImageLoader.shared
    private let appearance: Appearance
    private var id: Int?
    private var price: UInt?
    private var fullPrice: UInt?
    private var tapHandler: ((Int) -> Void)?
    private var updateHandler: (((Int, Int)) -> Void)?

    private lazy var lineLayer: CALayer = {
        let layer = CALayer()
        layer.frame = CGRect(
            x: .zero,
            y: bounds.size.height - appearance.layerOffset,
            width: bounds.size.width,
            height: appearance.borderWidth
        )
        layer.borderWidth = appearance.borderWidth
        layer.borderColor = appearance.borderBackgroundColor
        return layer
    }()

    private lazy var productImageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.textColor = UIColor.white
        label.font = Font.sber(ofSize: Font.Size.fouthteen, weight: .regular)
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

    private lazy var idLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor.gray
        label.font = Font.sber(ofSize: Font.Size.thirteen, weight: .regular)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.1
        label.attributedText = NSMutableAttributedString(
            string: "Item number: ",
            attributes: [
                .kern: 0.37,
                .paragraphStyle: paragraphStyle
            ]
        )
        return label
    }()

    private lazy var brandLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor.gray
        label.font = Font.sber(ofSize: Font.Size.thirteen, weight: .regular)
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

    private lazy var priceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor.gray
        label.font = Font.sber(ofSize: Font.Size.seventeen, weight: .regular)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.1
        label.attributedText = NSMutableAttributedString(
            string: "333 руб",
            attributes: [
                .kern: 0.37,
                .paragraphStyle: paragraphStyle
            ]
        )
        return label
    }()

    private lazy var minusButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(appearance.minusIconGray, for: .normal)
        button.imageView?.tintColor = appearance.whiteColor
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var countLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = Font.sber(ofSize: Font.Size.thirteen, weight: .regular)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.1
        paragraphStyle.alignment = .center
        label.attributedText = NSMutableAttributedString(
            string: "1",
            attributes: [
                .kern: 0.37,
                .paragraphStyle: paragraphStyle
            ]
        )
        return label
    }()

    private lazy var plusButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(appearance.plusIcon, for: .normal)
        button.imageView?.tintColor = appearance.whiteColor
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var editButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(appearance.elipsisIcon, for: .normal)
        button.imageView?.tintColor = appearance.whiteColor
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .top
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .white
        return indicator
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.appearance = Appearance()
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
        productImageView.image = nil
        [nameLabel, idLabel, brandLabel, countLabel, priceLabel].forEach { $0.text = "" }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        lineLayer.removeFromSuperlayer()
        self.layer.insertSublayer(lineLayer, at: 0)
    }
}

extension CartCell {
    
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
        self.id = viewModel.id
        self.price = viewModel.price
        self.fullPrice = viewModel.fullPrice
        if viewModel.count > 1 {
            minusButton.imageView?.tintColor = appearance.purpleColor
            plusButton.imageView?.tintColor = appearance.purpleColor
        } else {
            minusButton.imageView?.tintColor = appearance.whiteColor
            plusButton.imageView?.tintColor = appearance.purpleColor
        }
        self.tapHandler = viewModel.editHandler
        self.updateHandler = viewModel.updateHandler

        nameLabel.text = viewModel.name
        countLabel.text = "\(viewModel.count)"

        var attributedText = NSMutableAttributedString(
            string: "Item number: ",
            attributes: [.foregroundColor: UIColor.gray]
        )
        var attributedString2 = NSMutableAttributedString(
            string: "\(viewModel.id)",
            attributes: [.foregroundColor: UIColor.white]
        )
        attributedText.append(attributedString2)
        idLabel.attributedText = attributedText

        attributedText = NSMutableAttributedString(string: "Brand: ", attributes: [.foregroundColor: UIColor.gray])
        attributedString2 = NSMutableAttributedString(
            string: "\(viewModel.brand)",
            attributes: [.foregroundColor: UIColor.white]
        )
        attributedText.append(attributedString2)
        brandLabel.attributedText = attributedText

        if let priceText = CurrencyFormatter.shared.convertTostring(
            from: Double(viewModel.price * UInt(viewModel.count))
        ),
           let fullPriceText = CurrencyFormatter.shared.convertTostring(
            from: Double(viewModel.fullPrice * UInt(viewModel.count))
           ) {
            createPrice(&attributedText, priceText, &attributedString2, fullPriceText)
        }
        activityIndicator.startAnimating()
        imageLoader.loadImage(for: viewModel.thumbnail) { [weak self] result in
            guard let `self` else { return }
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.productImageView.setImage(image)
                }

            case .failure(let error):
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.productImageView.image = self.appearance.photoIcon
                    print(error)
                }
            }
        }
    }

    @objc func plusButtonTapped() {
        guard let price,
              let fullPrice,
              let id,
              let countLabelText = countLabel.text,
              var count = Int(countLabelText)
        else {
            return
        }
        count += 1
        var attributedText = NSMutableAttributedString(string: "", attributes: [.foregroundColor: UIColor.gray])
        var attributedString2 = NSMutableAttributedString(string: "", attributes: [.foregroundColor: UIColor.white])
        minusButton.imageView?.tintColor = appearance.purpleColor
        countLabel.text = "\(count)"
        if let priceText = CurrencyFormatter.shared.convertTostring(from: Double(price * UInt(count))),
           let fullPriceText = CurrencyFormatter.shared.convertTostring(from: Double(fullPrice * UInt(count))) {
            createPrice(&attributedText, priceText, &attributedString2, fullPriceText)
        }
        self.updateHandler?((id, count))
    }

    @objc func minusButtonTapped() {
        guard let price,
              let fullPrice,
              let id,
              let countLabelText = countLabel.text,
              let count = Int(countLabelText)
        else {
            return
        }
        if count > 1 {
            var attributedText = NSMutableAttributedString(string: "", attributes: [.foregroundColor: UIColor.gray])
            var attributedString2 = NSMutableAttributedString(string: "", attributes: [.foregroundColor: UIColor.white])
            minusButton.imageView?.tintColor = appearance.purpleColor
            countLabel.text = "\(count - 1)"
            if let priceText = CurrencyFormatter.shared.convertTostring(from: Double(price * UInt(count - 1))),
               let fullPriceText = CurrencyFormatter.shared.convertTostring(from: Double(fullPrice * UInt(count - 1))) {
                createPrice(&attributedText, priceText, &attributedString2, fullPriceText)
            }
            if (count - 1) == 1 {
                minusButton.imageView?.tintColor = appearance.whiteColor
            }
            self.updateHandler?((id, count - 1))
        } else {
            self.updateHandler?((id, count))
        }
    }

    @objc func editButtonTapped() {
        guard let id else { return }
        self.tapHandler?(id)
    }
}

// MARK: - ProgrammaticallyInitializableViewProtocol
extension CartCell: ProgrammaticallyInitializableViewProtocol {
    
    func setupView() {
        CurrencyFormatter.shared.configurate()
        backgroundColor = .clear
        self.contentView.layer.cornerRadius = 10
        contentView.backgroundColor = Colors.cellColor
    }

    func setupSubviews() {
        [productImageView, nameLabel, idLabel, brandLabel,
         priceLabel, minusButton, plusButton, countLabel,
         editButton, activityIndicator].forEach { contentView.addSubview($0) }
    }

    func setupConstraints() {
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        brandLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            productImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 17),
            productImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 13),
            productImageView.widthAnchor.constraint(equalToConstant: 87),
            productImageView.heightAnchor.constraint(equalToConstant: 113),

            nameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 13),
            nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 3),
            nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),

            idLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 13),
            idLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3),
            idLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 50),

            brandLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 13),
            brandLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 5),
            brandLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 50),

            priceLabel.leadingAnchor.constraint(equalTo: productImageView.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -13),
            priceLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 30),

            minusButton.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 13),
            minusButton.bottomAnchor.constraint(equalTo: productImageView.bottomAnchor),
            minusButton.heightAnchor.constraint(equalToConstant: 30),
            minusButton.widthAnchor.constraint(equalToConstant: 30),

            countLabel.leadingAnchor.constraint(equalTo: minusButton.trailingAnchor, constant: 5),
            countLabel.bottomAnchor.constraint(equalTo: minusButton.bottomAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 30),
            countLabel.widthAnchor.constraint(equalToConstant: 30),

            plusButton.leadingAnchor.constraint(equalTo: countLabel.trailingAnchor, constant: 5),
            plusButton.bottomAnchor.constraint(equalTo: countLabel.bottomAnchor),
            plusButton.heightAnchor.constraint(equalToConstant: 30),
            plusButton.widthAnchor.constraint(equalToConstant: 30),

            editButton.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            editButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            editButton.heightAnchor.constraint(equalToConstant: 30),
            editButton.widthAnchor.constraint(equalToConstant: 30),

            activityIndicator.centerXAnchor.constraint(equalTo: self.productImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.productImageView.centerYAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}
