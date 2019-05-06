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
            let button = UIButton().then {
                $0.setImage(#imageLiteral(resourceName: "star_fill"), for: .normal)
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.heightAnchor.constraint(equalToConstant: starSize).isActive = true
                $0.widthAnchor.constraint(equalToConstant: starSize).isActive = true
            }
            addArrangedSubview(button)
            ratingButtons.append(button)
        }
    }
}
