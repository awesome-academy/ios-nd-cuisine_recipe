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
}
