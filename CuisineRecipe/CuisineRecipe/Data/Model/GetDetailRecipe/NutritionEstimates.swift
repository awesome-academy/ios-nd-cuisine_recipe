//
//  NutritionEstimates.swift
//  CuisineRecipe
//
//  Created by mac on 4/24/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import Foundation

struct NutritionEstimates: Codable {
    let attribute: String?
    let description: String?
    let value: Double?
    let unit: Unit?
    
    enum CodingKeys: String, CodingKey {
        
        case attribute
        case description
        case value
        case unit 
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        attribute = try values.decodeIfPresent(String.self, forKey: .attribute)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        value = try values.decodeIfPresent(Double.self, forKey: .value)
        unit = try values.decodeIfPresent(Unit.self, forKey: .unit)
    }
}
