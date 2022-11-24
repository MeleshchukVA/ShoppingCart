//
//  BaseView.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 31.10.2022.
//

import UIKit

class BaseView: UIView {
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .whiteLarge)
        activity.color = Colors.lightGray
        return activity
    }()
}
