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
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        sourceRecipeUrl = try values.decodeIfPresent(String.self, forKey: .sourceRecipeUrl)
        sourceSiteUrl = try values.decodeIfPresent(String.self, forKey: .sourceSiteUrl)
        sourceDisplayName = try values.decodeIfPresent(String.self, forKey: .sourceDisplayName)
    }
}
