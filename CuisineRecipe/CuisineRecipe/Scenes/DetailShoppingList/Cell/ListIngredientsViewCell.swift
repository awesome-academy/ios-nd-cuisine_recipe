//
//  ListIngredientsViewCell.swift
//  CuisineRecipe
//
//  Created by mac on 5/7/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

final class ListIngredientsViewCell: UITableViewCell, NibReusable {
    @IBOutlet private weak var checkButton: UIButton!
    @IBOutlet private weak var nameOfIngredientLabel: UILabel!
    
    func configure(ingredient: IngredientMO) {
        checkButton.isSelected = ingredient.isBought
        nameOfIngredientLabel.text = ingredient.ingredientName
    }
}
