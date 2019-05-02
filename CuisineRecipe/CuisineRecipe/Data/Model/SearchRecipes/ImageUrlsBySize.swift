//
//  ImageUrlsBySize.swift
//  CuisineRecipe
//
//  Created by mac on 4/24/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import Foundation

struct ImageUrlsBySize: Codable {
    let size90: String?
    let size360: String?
    
    enum CodingKeys: String, CodingKey {
        case size90 = "90"
        case size360 = "360"
    }
}
