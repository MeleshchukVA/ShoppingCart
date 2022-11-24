//
//  ProfileViewController.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 24.11.2022.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private let output: ProfileViewOutput
    lazy var profileView = self.view as? ProfileView

    init(output: ProfileViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = ProfileView(frame: UIScreen.main.bounds)
        self.view = view
    }

    override func viewDidLoad() {
        output.viewDidLoad()
        super.viewDidLoad()
    }
}

extension ProfileViewController: ProfileViewInput {
    
    func failToGetUser() {
        profileView?.stopActivityIndicator()
    }

    func failToGetImage() {
        profileView?.setupAvatar(image: nil)
    }

    func setupAvatar(image: UIImage) {
        profileView?.setupAvatar(image: image)
    }

    func setupUser(user: User) {
        profileView?.stopActivityIndicator()
        profileView?.fillProfile(user)
    }
}
