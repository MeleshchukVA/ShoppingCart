//
//  BaseView.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 31.10.2022.
//

import UIKit

// MARK: - BaseView class

class BaseView: UIView {
    
    // MARK: Properties
    // ActitivityIndicator существует для каждого View.
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .whiteLarge)
        activity.color = .white
        return activity
    }()
}
