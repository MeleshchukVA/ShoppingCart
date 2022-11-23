//
//  UIImageView + Extension.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 22.11.2022.
//

import UIKit.UIImageView

extension UIImageView {
    func setImage(_ image: UIImage?) {
        UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.image = image
        }, completion: nil)
    }
}
