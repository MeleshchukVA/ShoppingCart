//
//  ProfileView.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 24.11.2022.
//

import UIKit

// MARK: - ProfileView + Appearance

extension ProfileView {
    
    struct Appearance {
        
        let tableViewBackgroundColor = UIColor.black
        let purpleColor = Colors.purple
        let lightGrayColor = Colors.lightGray
        let textCollor = Colors.lightWhite
        let topInset: CGFloat = 20
        let sideInset: CGFloat = 10
        let avatarSize: CGFloat = 160
        let textfieldHeight: CGFloat = 50
        let verticalSpacing: CGFloat = 10
        let labelHeight: CGFloat = 25
        let cornerRadius: CGFloat = 10
        let borderWidth: CGFloat = 2
    }
}

// MARK: - ProfileView class

final class ProfileView: BaseView {
    
    // MARK: Properties
    let appearance: Appearance

    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        return view
    }()

    private lazy var contentView: UIView = {
        UIView(frame: .zero)
    }()

    private lazy var avatarView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.clipsToBounds = true
        view.backgroundColor = appearance.lightGrayColor
        view.layer.borderColor = appearance.purpleColor.cgColor
        view.layer.borderWidth = appearance.borderWidth
        view.layer.cornerRadius = appearance.avatarSize / 2
        return view
    }()

    private lazy var nameLabel: UILabel = {
        makeLabel(text: "Name")
    }()

    private lazy var nameField: TextField = {
        makeTextfield(placeholder: "Name")
    }()

    private lazy var lastnameLabel: UILabel = {
        makeLabel(text: "Lastname")
    }()

    private lazy var lastnameField: TextField = {
        makeTextfield(placeholder: "Lastname")
    }()

    private lazy var emailLabel: UILabel = {
        makeLabel(text: "Email")
    }()

    private lazy var emailField: TextField = {
        makeTextfield(placeholder: "Email", keyboardType: .emailAddress)
    }()

    private lazy var passwordLabel: UILabel = {
        makeLabel(text: "Password")
    }()

    private lazy var passwordField: TextField = {
        makeTextfield(placeholder: "Password", isSecureTextEntry: true)
    }()
    
    // MARK: Init
    init(
        frame: CGRect,
        appearance: Appearance = Appearance()
    ) {
        self.appearance = appearance
        super.init(frame: frame)
        self.setupView()
        self.setupSubviews()
        self.setupConstraints()
        self.startActivityIndicator()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ProfileView private extension

private extension ProfileView {
    
    func makeTextfield(
        placeholder: String,
        keyboardType: UIKeyboardType = .default,
        isSecureTextEntry: Bool = false
    ) -> TextField {
        let textfield = TextField()
        textfield.backgroundColor = appearance.lightGrayColor
        textfield.textColor = appearance.textCollor
        textfield.layer.borderColor = appearance.purpleColor.cgColor
        textfield.layer.borderWidth = appearance.borderWidth
        textfield.layer.cornerRadius = appearance.cornerRadius
        textfield.placeholder = placeholder
        textfield.keyboardType = keyboardType
        textfield.isSecureTextEntry = isSecureTextEntry
        textfield.isEnabled = false
        return textfield
    }

    func makeLabel(text: String) -> UILabel {
        let label = UILabel(frame: .zero)
        label.text = text
        label.textColor = appearance.textCollor
        return label
    }
}

// MARK: - ProfileView public extension

extension ProfileView {
    
    func fillProfile(_ user: User) {
        nameField.text = user.firstName
        lastnameField.text = user.lastName
        emailField.text = user.email
        passwordField.text = user.password
    }

    func setupAvatar(image: UIImage?) {
        if image == nil {
            self.avatarView.image = UIImage(named: "placeholder")
        } else {
            self.avatarView.setImage(image)
        }
    }

    func startActivityIndicator() {
        contentView.isHidden = true
        activityIndicator.startAnimating()
    }

    func stopActivityIndicator() {
        contentView.isHidden = false
        activityIndicator.stopAnimating()
    }
}

// MARK: - ProgrammaticallyInitializableViewProtocol

extension ProfileView: ProgrammaticallyInitializableViewProtocol {
    
    func setupView() {
        self.backgroundColor = .black
    }

    func setupSubviews() {
        [scrollView, activityIndicator].forEach {
            self.addSubview($0)
        }
        [avatarView, nameLabel, nameField, lastnameLabel,
         lastnameField, emailLabel, emailField,
         passwordLabel, passwordField].forEach {
            contentView.addSubview($0)
         }
        self.scrollView.addSubview(contentView)
    }

    func setupConstraints() {
        [scrollView, contentView, avatarView, nameField,
         lastnameField, emailField, passwordField, nameLabel,
         lastnameLabel, emailLabel, passwordLabel, activityIndicator].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
         }

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -appearance.sideInset),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: appearance.sideInset),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: self.heightAnchor),
            contentView.widthAnchor.constraint(
                equalTo: scrollView.widthAnchor,
                constant: -(appearance.sideInset * 2)
            ),

            avatarView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: appearance.topInset),
            avatarView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avatarView.heightAnchor.constraint(equalToConstant: appearance.avatarSize),
            avatarView.widthAnchor.constraint(equalToConstant: appearance.avatarSize),

            nameLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: appearance.verticalSpacing),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: appearance.labelHeight),

            nameField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            nameField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameField.heightAnchor.constraint(equalToConstant: appearance.textfieldHeight),

            lastnameLabel.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: appearance.verticalSpacing),
            lastnameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lastnameLabel.heightAnchor.constraint(equalToConstant: appearance.labelHeight),

            lastnameField.topAnchor.constraint(equalTo: lastnameLabel.bottomAnchor),
            lastnameField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lastnameField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            lastnameField.heightAnchor.constraint(equalToConstant: appearance.textfieldHeight),

            emailLabel.topAnchor.constraint(
                equalTo: lastnameField.bottomAnchor,
                constant: appearance.verticalSpacing
            ),
            emailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            emailLabel.heightAnchor.constraint(equalToConstant: appearance.labelHeight),

            emailField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor),
            emailField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            emailField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            emailField.heightAnchor.constraint(equalToConstant: appearance.textfieldHeight),

            passwordLabel.topAnchor.constraint(
                equalTo: emailField.bottomAnchor,
                constant: appearance.verticalSpacing
            ),
            passwordLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            passwordLabel.heightAnchor.constraint(equalToConstant: appearance.labelHeight),

            passwordField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor),
            passwordField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            passwordField.heightAnchor.constraint(equalToConstant: appearance.textfieldHeight)
        ])
    }
}
