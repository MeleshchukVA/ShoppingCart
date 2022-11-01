//
//  BaseView.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 31.10.2022.
//

import UIKit

class BaseView: UIView {
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.color = Colors.lightGray
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
}
