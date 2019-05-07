//
//  PaddingLabel.swift
//  CuisineRecipe
//
//  Created by mac on 5/8/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

final class PaddingLabel: UILabel {
    let padding = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
}
