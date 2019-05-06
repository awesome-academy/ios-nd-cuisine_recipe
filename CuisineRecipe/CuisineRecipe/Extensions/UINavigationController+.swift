//
//  UINavigationController+.swift
//  CuisineRecipe
//
//  Created by mac on 5/4/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

extension UINavigationController {    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}
