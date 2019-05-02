//
//  Recipe.swift
//  CuisineRecipe
//
//  Created by mac on 4/24/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import Foundation

struct RecipeInfoResponse: Codable {
    let yield: String?
    let nutritionEstimates: [NutritionEstimates]?
    let totalTime: String?
    let images: [Images]?
    let name: String?
    let source: Source?
    let prepTime: String?
    let id: String?
    let ingredientLines: [String]?
    let cookTime: String?
    let attribution: Attribution?
    let numberOfServings: Int?
    let totalTimeInSeconds: Int?
    let attributes: Attributes?
    let cookTimeInSeconds: Int?
    let flavors: Flavors?
    let rating: Int?
    
    enum CodingKeys: String, CodingKey {
        case yield
        case nutritionEstimates
        case totalTime
        case images
        case name
        case source
        case prepTime
        case id
        case ingredientLines
        case cookTime
        case attribution
        case numberOfServings
        case totalTimeInSeconds
        case attributes
        case cookTimeInSeconds
        case flavors
        case rating
    }
}
