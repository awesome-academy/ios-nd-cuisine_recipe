//
//  StarRating.swift
//  CuisineRecipe
//
//  Created by mac on 5/4/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

final class StarRating: UIStackView {
    private var ratingButtons = [UIButton]()
    private let starSize: CGFloat = 25.0
    
    func setupButtons(starCount: Int) {
        for _ in 0..<starCount {
            let button = UIButton()
            button.setImage(#imageLiteral(resourceName: "star_fill"), for: .normal)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize).isActive = true
            
            addArrangedSubview(button)
            ratingButtons.append(button)
        }
    }
}
