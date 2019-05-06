//
//  DetailRecipeCell.swift
//  CuisineRecipe
//
//  Created by mac on 5/4/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

final class DetailRecipeCell: UICollectionViewCell, NibReusable {
    @IBOutlet private weak var nutriName: UILabel!
    @IBOutlet private weak var nutriValue: UILabel!
    
    func configure(nutri: NutritionEstimates) {
        guard let nutritionValue = nutri.value, let nutritionName = nutri.unit?.name else {
            return
        }
        nutriName.text = nutri.description ?? nutri.attribute
        nutriValue.text = String(nutritionValue) + " " + nutritionName
    }
}
