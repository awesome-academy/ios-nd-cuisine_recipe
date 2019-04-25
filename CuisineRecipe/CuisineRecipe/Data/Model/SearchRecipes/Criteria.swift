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
    let requirePictures: Bool
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
        case requirePictures
        case facetFields
        case terms
        case allowedAttributes 
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        maxResults = try values.decodeIfPresent(Int.self, forKey: .maxResults)
        excludedIngredients = try values.decodeIfPresent([String].self, forKey: .excludedIngredients)
        excludedAttributes = try values.decodeIfPresent([String].self, forKey: .excludedAttributes)
        allowedIngredients = try values.decodeIfPresent([String].self, forKey: .allowedIngredients)
        attributeRanges = try values.decodeIfPresent(AttributeRanges.self, forKey: .attributeRanges)
        nutritionRestrictions = try values.decodeIfPresent(NutritionRestrictions.self, forKey: .nutritionRestrictions)
        allowedDiets = try values.decodeIfPresent([String].self, forKey: .allowedDiets)
        resultsToSkip = try values.decodeIfPresent(Int.self, forKey: .resultsToSkip)
        requirePictures = try values.decodeIfPresent(Bool.self, forKey: .requirePictures) ?? false
        facetFields = try values.decodeIfPresent([String].self, forKey: .facetFields)
        terms = try values.decodeIfPresent([String].self, forKey: .terms)
        allowedAttributes = try values.decodeIfPresent([String].self, forKey: .allowedAttributes)
    }
}

