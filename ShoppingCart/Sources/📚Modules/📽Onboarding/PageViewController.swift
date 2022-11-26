//
//  PageViewController.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 23.11.2022.
//

import UIKit

// MARK: - ImageType enum

enum ImageType: String {
    
    case welcome = "hand.wave"
    case search = "magnifyingglass"
    case stored = "tray.2"
    case image = "photo"
}

// MARK: - PageViewController + Appearence

extension PageViewController {
    
    struct Appearence {
        
        let stackViewHeight: CGFloat = 100
        let bold34 = Font.sber(ofSize: Font.Size.thirtyFour, weight: .bold)
        let backgroundColor = Colors.purple
        let foregroundColor = Colors.lightWhite
        let unselectedForegroundColor = Colors.lightGray
    }
}

// MARK: - PageViewController class

final class PageViewController: UIViewController {
    
    // MARK: Properties
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
    
    private lazy var textLabelEmptyView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // MARK: Init
    init(imageType: ImageType, text: String) {
        self.imageType = imageType
        self.text = text
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSubviews()
        setupConstraints()
    }
}

// MARK: - ProgrammaticallyInitializableViewProtocol

extension PageViewController: ProgrammaticallyInitializableViewProtocol {
    
    func setupView() {
        self.view.backgroundColor = .clear
        
        textLabel.sizeToFit()
    }

    func setupSubviews() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(textLabelEmptyView)
        
        textLabelEmptyView.addSubview(textLabel)
    }

    func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor),
            stackView.heightAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.heightAnchor,
                constant: -appearence.stackViewHeight
            ),

            textLabel.centerXAnchor.constraint(equalTo: self.textLabelEmptyView.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: self.textLabelEmptyView.centerYAnchor),
            textLabel.widthAnchor.constraint(equalTo: self.textLabelEmptyView.widthAnchor),
            textLabel.heightAnchor.constraint(equalTo: self.textLabelEmptyView.heightAnchor)
        ])
    }
}
