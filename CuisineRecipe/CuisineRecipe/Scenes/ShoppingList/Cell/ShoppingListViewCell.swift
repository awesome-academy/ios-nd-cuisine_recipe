//
//  ShoppingListViewCell.swift
//  CuisineRecipe
//
//  Created by mac on 5/6/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

final class ShoppingListViewCell: UITableViewCell, NibReusable {
    @IBOutlet private weak var imageRecipe: UIImageView!
    @IBOutlet private weak var recipeNameLabel: UILabel!
    @IBOutlet private weak var numIngredientsMissing: UILabel!
    
    func configure(recipe: RecipeMO) {
        guard let imgUrl = recipe.imageUrl,
            let ingredients = recipe.ingredients?.allObjects as? [IngredientMO] else { return }
        
        let count = ingredients.filter({ $0.isBought == false }).count
        
        imageRecipe.loadImageFromUrl(urlString: imgUrl)
        recipeNameLabel.text = recipe.recipeName
        numIngredientsMissing.text = String(count) + " ingredients missing"
    }
}
