//
//  Recipe.swift
//  CuisineRecipe
//
//  Created by mac on 4/24/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import Foundation

struct RecipeInfoResponse: Codable {
    let attribution: Attribution?
    let ingredientLines: [String]?
    let flavors: Flavors?
    let nutritionEstimates: [NutritionEstimates]?
    let images: [Images]?
    let name: String?
    let yield: String?
    let totalTime: String?
    let attributes: Attributes?
    let totalTimeInSeconds: Int?
    let rating: Double?
    let numberOfServings: Int?
    let source: Source?
    let id: String?
    
    enum CodingKeys: String, CodingKey {
        
        case attribution
        case ingredientLines
        case flavors
        case nutritionEstimates
        case images
        case name
        case yield
        case totalTime
        case attributes
        case totalTimeInSeconds
        case rating
        case numberOfServings
        case source
        case id 
    }
}
