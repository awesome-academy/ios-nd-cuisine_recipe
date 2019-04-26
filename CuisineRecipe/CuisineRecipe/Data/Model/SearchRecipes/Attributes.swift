//
//  Attributes.swift
//  CuisineRecipe
//
//  Created by mac on 4/24/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import Foundation

struct Attributes: Codable {
    let course: [String]?
    let cuisine: [String]?
    
    enum CodingKeys: String, CodingKey {
        case course
        case cuisine 
    }
}
