//
//  UIImageView+.swift
//  CuisineRecipe
//
//  Created by mac on 5/3/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

extension UIImageView {
    func setupGradientBarBottom(width: CGFloat, height: CGFloat) {
        let sHeight: CGFloat = height / 2
        let shadow = UIColor(hexString: "464646").withAlphaComponent(1.0).cgColor
        
        // Add gradient bar for image on bottom
        let bottomImageGradient = CAGradientLayer()
        bottomImageGradient.frame = CGRect(x: 0, y: sHeight, width: width, height: sHeight)
        bottomImageGradient.colors = [UIColor.clear.cgColor, shadow]
        self.layer.insertSublayer(bottomImageGradient, at: 0)
    }
}
