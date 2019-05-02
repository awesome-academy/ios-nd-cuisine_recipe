//
//  Recipes.swift
//  CuisineRecipe
//
//  Created by mac on 4/24/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import Foundation

struct RecipesResponse: Codable {
    let attribution: Attribution?
    let totalMatchCount: Int?
    let matches: [Recipes]?
    let criteria: Criteria?
    
    enum CodingKeys: String, CodingKey {
        
        case attribution
        case totalMatchCount
        case matches
        case criteria 
    }
}
