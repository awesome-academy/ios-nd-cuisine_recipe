//
//  FAT.swift
//  CuisineRecipe
//
//  Created by mac on 4/24/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import Foundation

struct FAT: Codable {
    let min: Int?
    let max: Int?
    
    enum CodingKeys: String, CodingKey {
        
        case min
        case max
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        min = try values.decodeIfPresent(Int.self, forKey: .min)
        max = try values.decodeIfPresent(Int.self, forKey: .max)
    }
}
