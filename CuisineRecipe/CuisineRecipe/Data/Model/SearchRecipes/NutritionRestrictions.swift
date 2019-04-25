//
//  NutritionRestrictions.swift
//  CuisineRecipe
//
//  Created by mac on 4/24/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import Foundation

struct NutritionRestrictions: Codable {
    let fAT: FAT?
    
    enum CodingKeys: String, CodingKey {
        
        case fAT = "FAT"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fAT = try values.decodeIfPresent(FAT.self, forKey: .fAT)
    }
}
