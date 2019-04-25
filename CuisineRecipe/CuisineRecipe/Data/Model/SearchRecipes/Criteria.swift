//
//  Criteria.swift
//  CuisineRecipe
//
//  Created by mac on 4/24/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import Foundation

struct Criteria: Codable {
    let maxResults: Int?
    let excludedIngredients: [String]?
    let excludedAttributes: [String]?
    let allowedIngredients: [String]?
    let attributeRanges: AttributeRanges?
    let nutritionRestrictions: NutritionRestrictions?
    let allowedDiets: [String]?
    let resultsToSkip: Int?
    let facetFields: [String]?
    let terms: [String]?
    let allowedAttributes: [String]?
    
    enum CodingKeys: String, CodingKey {
        case maxResults
        case excludedIngredients
        case excludedAttributes
        case allowedIngredients
        case attributeRanges
        case nutritionRestrictions
        case allowedDiets
        case resultsToSkip
        case facetFields
        case terms
        case allowedAttributes 
    }
}

