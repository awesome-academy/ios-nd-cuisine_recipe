//
//  ImageUrlsBySize.swift
//  CuisineRecipe
//
//  Created by mac on 4/24/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import Foundation

struct ImageUrlsBySize: Codable {
    let size: String?
    
    enum CodingKeys: String, CodingKey {
        
        case size = "90"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        size = try values.decodeIfPresent(String.self, forKey: .size)
    }
}
