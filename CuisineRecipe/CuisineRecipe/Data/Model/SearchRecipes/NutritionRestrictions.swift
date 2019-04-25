//
//  NutritionRestrictions.swift
//  CuisineRecipe
//
//  Created by mac on 4/24/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import Foundation

struct NutritionRestrictions: Codable {
    let totalLipid: TotalLipid?
    
    enum CodingKeys: String, CodingKey {
        case totalLipid = "FAT"
    }
}
