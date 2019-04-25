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
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        attribution = try values.decodeIfPresent(Attribution.self, forKey: .attribution)
        ingredientLines = try values.decodeIfPresent([String].self, forKey: .ingredientLines)
        flavors = try values.decodeIfPresent(Flavors.self, forKey: .flavors)
        nutritionEstimates = try values.decodeIfPresent([NutritionEstimates].self, forKey: .nutritionEstimates)
        images = try values.decodeIfPresent([Images].self, forKey: .images)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        yield = try values.decodeIfPresent(String.self, forKey: .yield)
        totalTime = try values.decodeIfPresent(String.self, forKey: .totalTime)
        attributes = try values.decodeIfPresent(Attributes.self, forKey: .attributes)
        totalTimeInSeconds = try values.decodeIfPresent(Int.self, forKey: .totalTimeInSeconds)
        rating = try values.decodeIfPresent(Double.self, forKey: .rating)
        numberOfServings = try values.decodeIfPresent(Int.self, forKey: .numberOfServings)
        source = try values.decodeIfPresent(Source.self, forKey: .source)
        id = try values.decodeIfPresent(String.self, forKey: .id)
    }
}
