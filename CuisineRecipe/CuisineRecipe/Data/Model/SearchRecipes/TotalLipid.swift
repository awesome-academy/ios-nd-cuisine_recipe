//
//  FAT.swift
//  CuisineRecipe
//
//  Created by mac on 4/24/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import Foundation

struct TotalLipid: Codable {
    let min: Int?
    let max: Int?
    
    enum CodingKeys: String, CodingKey {
        case min
        case max
    }
}
