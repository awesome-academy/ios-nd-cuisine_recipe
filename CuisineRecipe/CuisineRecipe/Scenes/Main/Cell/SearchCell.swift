//
//  SearchCell.swift
//  CuisineRecipe
//
//  Created by mac on 5/3/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

final class SearchCell: UICollectionViewCell, NibReusable {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var timeCooking: UILabel!

    func setContent(recipe: Recipe) {
        guard let urlString = recipe.imageUrlsBySize?.size90 else { return }
        guard let totalTime = recipe.totalTimeInSeconds else { return }
        
        imageView.setupGradientBarBottom(width: self.frame.width, height: self.frame.height)
        imageView.loadImageFromUrl(urlString: urlString)
        title.text = recipe.recipeName
        timeCooking.text = String(totalTime / 60) + " min."
    }
}
