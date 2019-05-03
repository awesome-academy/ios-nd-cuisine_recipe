//
//  CustomSpinner.swift
//  CuisineRecipe
//
//  Created by mac on 5/3/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

final class CustomSpinner: UIActivityIndicatorView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView() {
        self.style = .gray
        self.stopAnimating()
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: CGFloat(44))
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
