//
//  ProductCell.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 18.11.2022.
//

import UIKit

// MARK: - ProductCell + Appearance

extension ProductCell {

    struct Appearance {
        
        let cardButtonImagePlus = Localize.Images.cartPlusIcon
        let cardButtonImageMinus = Localize.Images.cartMinusIcon
    }
}

// MARK: - ProductCell class

final class ProductCell: UICollectionViewCell {

    // MARK: Properties
    private let imageLoader: ImageLoaderProtocol = ImageLoader.shared
    private let appearance: Appearance
    private var id: Int?
    private var tapHandler: ((Int) -> Void)?

    private lazy var imageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = ProductConstants.Layout.cornerRadius
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        return image
    }()

    private lazy var cardButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(appearance.cardButtonImagePlus, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(cardButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var ratingLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.textAlignment = .center
        label.font = Font.sber(ofSize: Font.Size.thirteen, weight: .bold)
        label.layer.cornerRadius = 4
        label.layer.backgroundColor = Colors.rose.cgColor
        label.layer.masksToBounds = true
        return label
    }()

    private lazy var discountLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.textAlignment = .center
        label.font = Font.sber(ofSize: Font.Size.thirteen, weight: .bold)
        label.layer.cornerRadius = 4
        label.layer.backgroundColor = UIColor.black.cgColor
        label.layer.masksToBounds = true
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.font = Font.sber(ofSize: Font.Size.fithteen, weight: .bold)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        label.attributedText = NSMutableAttributedString(
            string: "1000,00 $",
            attributes: [
                .kern: -0.41,
                .paragraphStyle: paragraphStyle
            ]
        )
        return label
    }()

    private lazy var brandLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.font = Font.sber(ofSize: Font.Size.eleven, weight: .regular)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.01
        label.attributedText = NSMutableAttributedString(
            string: "apple",
            attributes: [
                .kern: -0.24,
                .paragraphStyle: paragraphStyle
            ]
        )
        return label
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = Colors.grayTabBar
        label.font = Font.sber(ofSize: Font.Size.eleven, weight: .regular)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.lineHeightMultiple = 0.99
        label.attributedText = NSMutableAttributedString(
            string: "macbook pro",
            attributes: [
                .kern: 0.07,
                .paragraphStyle: paragraphStyle
            ]
        )
        return label
    }()

    private lazy var stockLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = Colors.grayTabBar
        label.adjustsFontSizeToFitWidth = true
        label.font = Font.sber(ofSize: Font.Size.eleven, weight: .regular)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.99
        label.attributedText = NSMutableAttributedString(
            string: "in stock",
            attributes: [
                .kern: 0.07,
                .paragraphStyle: paragraphStyle
            ]
        )
        return label
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .white
        return indicator
    }()

    // MARK: Init
    override init(frame: CGRect) {
        self.appearance = Appearance()
        super.init(frame: frame)
        self.setupView()
        self.setupSubviews()
        self.setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Override methods
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        [priceLabel, discountLabel, brandLabel, titleLabel, stockLabel].forEach { $0.text = "" }
    }
}

// MARK: - ProgrammaticallyInitializableViewProtocol

extension ProductCell: ProgrammaticallyInitializableViewProtocol {

    func setupView() {
        CurrencyFormatter.shared.configurate()
        layer.cornerRadius = ProductConstants.Layout.cornerRadius
        layer.masksToBounds = false
    }

    func setupSubviews() {
        imageView.addSubview(ratingLabel)
        [imageView, cardButton, priceLabel, discountLabel,
         brandLabel, titleLabel, stockLabel, activityIndicator].forEach {
            contentView.addSubview($0)
         }
    }

    func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        cardButton.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        discountLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        brandLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stockLabel.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(
                equalTo: self.contentView.bottomAnchor,
                constant: -(ProductConstants.Layout.heightProductCard - 17)
            ),

            ratingLabel.leadingAnchor.constraint(equalTo: self.imageView.leadingAnchor, constant: 5),
            ratingLabel.bottomAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: -5),

            discountLabel.trailingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: -5),
            discountLabel.bottomAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: -5),

            cardButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 3),
            cardButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            cardButton.heightAnchor.constraint(equalToConstant: 35),
            cardButton.widthAnchor.constraint(equalToConstant: 35),

            priceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 3),
            priceLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: cardButton.leadingAnchor),

            brandLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            brandLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            brandLabel.trailingAnchor.constraint(equalTo: cardButton.leadingAnchor),

            titleLabel.topAnchor.constraint(equalTo: brandLabel.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),

            stockLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            stockLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            stockLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: self.imageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.imageView.centerYAnchor)
        ])
    }
}

// MARK: - ProductCell extension

extension ProductCell {

    // MARK: Actions
    @objc private func cardButtonTapped() {
        if let id = self.id {
            self.tapHandler?(id)

            UIView.animate(
                withDuration: 0.7,
                delay: .zero,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 0.5,
                options: .curveEaseIn
            ) {
                self.cardButton.setImage(self.appearance.cardButtonImageMinus, for: .normal)
                self.cardButton.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                guard let self = self else { return }
                self.cardButton.setImage(self.appearance.cardButtonImagePlus, for: .normal)
                UIView.animate(
                    withDuration: 1,
                    delay: .zero,
                    usingSpringWithDamping: 1,
                    initialSpringVelocity: 0.5,
                    options: .curveEaseOut
                ) {
                    self.cardButton.transform = CGAffineTransform(scaleX: 1, y: 1)
                }
            }
        }
    }

    // MARK: Public methods
    func fill(with viewModel: ProductViewModel) {
        self.id = viewModel.id
        self.tapHandler = viewModel.didTap

        discountLabel.text = "-\(Int(viewModel.discountPercentage))%"
        discountLabel.sizeToFit()
        discountLabel.frame = CGRect(
            x: 8,
            y: self.bounds.width - 38,
            width: discountLabel.frame.width + 11,
            height: discountLabel.frame.height + 7
        )

        ratingLabel.text = "⭐️ \(viewModel.rating)"
        ratingLabel.sizeToFit()
        ratingLabel.frame = CGRect(
            x: 8,
            y: self.bounds.width - 10,
            width: ratingLabel.frame.width + 11,
            height: ratingLabel.frame.height + 7
        )

        priceLabel.text = CurrencyFormatter.shared.convertTostring(from: Double(viewModel.price))
        brandLabel.text = viewModel.brand.capitalized
        titleLabel.text = viewModel.title
        stockLabel.text = "In stock - \(viewModel.stock)"

        activityIndicator.startAnimating()

        imageLoader.loadImage(for: viewModel.thumbnail) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.imageView.image = image
                }

            case .failure(let error):
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.imageView.image = UIImage(named: "placeholder")
                    print(error)
                }
            }
        }
    }
}
