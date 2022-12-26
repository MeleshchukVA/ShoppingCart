//
//  ProfileViewController.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 24.11.2022.
//

import UIKit

// MARK: - ProfileViewController class

final class ProfileViewController: UIViewController {
    
    // MARK: Properties
    private let output: ProfileViewOutput
    lazy var profileView = self.view as? ProfileView
    
    // MARK: Init
    init(output: ProfileViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Override methods
    override func loadView() {
        let view = ProfileView(frame: UIScreen.main.bounds)
        self.view = view
    }
    
    // Чтобы шел запрос в сеть, когда не было интернета и потом он появился.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.viewDidLoad()
    }
}

// MARK: - ProfileViewInput

extension ProfileViewController: ProfileViewInput {
    
    func failToGetUser() {
        DispatchQueue.main.async {
            self.profileView?.stopActivityIndicator()
        }
    }

    func failToGetImage() {
        DispatchQueue.main.async {
            self.profileView?.setupAvatar(image: nil)
        }
    }

    func setupAvatar(image: UIImage) {
        DispatchQueue.main.async {
            self.profileView?.setupAvatar(image: image)
        }
    }

    func setupUser(user: User) {
        DispatchQueue.main.async {
            self.profileView?.stopActivityIndicator()
            self.profileView?.fillProfile(user)
        }
    }
}
