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
    let matches: [Matches]?
    let criteria: Criteria?
    
    enum CodingKeys: String, CodingKey {
        
        case attribution
        case totalMatchCount
        case matches
        case criteria 
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        attribution = try values.decodeIfPresent(Attribution.self, forKey: .attribution)
        totalMatchCount = try values.decodeIfPresent(Int.self, forKey: .totalMatchCount)
        matches = try values.decodeIfPresent([Matches].self, forKey: .matches)
        criteria = try values.decodeIfPresent(Criteria.self, forKey: .criteria)
    }
}
