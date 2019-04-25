//
//  Flavor-piquant.swift
//  CuisineRecipe
//
//  Created by mac on 4/24/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import Foundation

struct FlavorPiquant: Codable {
    let min: Double?
    let max: Int?
    
    enum CodingKeys: String, CodingKey {
        case min
        case max
    }
}
