//
//  Source.swift
//  CuisineRecipe
//
//  Created by mac on 4/24/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import Foundation

struct Source: Codable {
    let sourceRecipeUrl: String?
    let sourceSiteUrl: String?
    let sourceDisplayName: String?
    
    enum CodingKeys: String, CodingKey {
        case sourceRecipeUrl 
        case sourceSiteUrl
        case sourceDisplayName 
    }
}
