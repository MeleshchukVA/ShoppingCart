//
//  PageViewController.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 23.11.2022.
//

import UIKit

enum ImageType: String {
    
    case welcome = "hand.wave"
    case search = "magnifyingglass"
    case stored = "tray.2"
    case image = "photo"
}

extension PageViewController {
    
    struct Appearence {
        
        let imageViewSize: CGFloat = 180
        let imageViewTopOffset: CGFloat = 120
        let textLabelTopOffset: CGFloat = 50
        let textLabelBottomOffset: CGFloat = 20

        let bold34 = Font.sber(ofSize: Font.Size.thirtyFour, weight: .bold)
        let backgroundColor = Colors.purple
        let foregroundColor = Colors.lightWhite
        let unselectedForegroundColor = Colors.lightGray
    }
}

// MARK: - доделать (унаследоваться от ProgInit)
final class PageViewController: UIViewController {
    
    private let appearence = Appearence()

    let imageType: ImageType
    let text: String

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: imageType.rawValue)
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = appearence.foregroundColor
        return imageView
    }()

    private lazy var textLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = text
        label.font = appearence.bold34
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = appearence.foregroundColor
        return label
    }()

    init(imageType: ImageType, text: String) {
        self.imageType = imageType
        self.text = text
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Private
extension PageViewController {
    
    private func setupUI() {
        self.view.backgroundColor = .clear
        setupSubviews()
        setupConstraints()
    }

    private func setupSubviews() {
        self.view.addSubview(imageView)
        self.view.addSubview(textLabel)
    }

    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.sizeToFit()

        let constraints = [
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: appearence.imageViewTopOffset),
            imageView.widthAnchor.constraint(equalToConstant: appearence.imageViewSize),
            imageView.heightAnchor.constraint(equalToConstant: appearence.imageViewSize),

            textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: appearence.textLabelBottomOffset),
            textLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            textLabel.widthAnchor.constraint(equalToConstant: textLabel.frame.width),
            textLabel.heightAnchor.constraint(equalToConstant: textLabel.frame.height)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
