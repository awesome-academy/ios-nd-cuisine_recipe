//
//  AttributeRanges.swift
//  CuisineRecipe
//
//  Created by mac on 4/24/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import Foundation

struct AttributeRanges: Codable {
    let flavorPiquant: FlavorPiquant?
    
    enum CodingKeys: String, CodingKey {
        
        case flavorPiquant = "flavor-piquant"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        flavorPiquant = try values.decodeIfPresent(FlavorPiquant.self, forKey: .flavorPiquant)
    }
}
