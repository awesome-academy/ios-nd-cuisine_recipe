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
    let name: String
    let source: Source?
    let prepTime: String?
    let id: String
    let ingredientLines: [String]?
    let cookTime: String?
    let attribution: Attribution?
    let numberOfServings: Int
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
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        yield = try values.decodeIfPresent(String.self, forKey: .yield)
        nutritionEstimates = try values.decodeIfPresent([NutritionEstimates].self, forKey: .nutritionEstimates)
        totalTime = try values.decodeIfPresent(String.self, forKey: .totalTime)
        images = try values.decodeIfPresent([Images].self, forKey: .images)
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        source = try values.decodeIfPresent(Source.self, forKey: .source)
        prepTime = try values.decodeIfPresent(String.self, forKey: .prepTime)
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        ingredientLines = try values.decodeIfPresent([String].self, forKey: .ingredientLines)
        cookTime = try values.decodeIfPresent(String.self, forKey: .cookTime)
        attribution = try values.decodeIfPresent(Attribution.self, forKey: .attribution)
        numberOfServings = try values.decodeIfPresent(Int.self, forKey: .numberOfServings) ?? 0
        totalTimeInSeconds = try values.decodeIfPresent(Int.self, forKey: .totalTimeInSeconds)
        attributes = try values.decodeIfPresent(Attributes.self, forKey: .attributes)
        cookTimeInSeconds = try values.decodeIfPresent(Int.self, forKey: .cookTimeInSeconds)
        flavors = try values.decodeIfPresent(Flavors.self, forKey: .flavors)
        rating = try values.decodeIfPresent(Int.self, forKey: .rating)
    }
}
