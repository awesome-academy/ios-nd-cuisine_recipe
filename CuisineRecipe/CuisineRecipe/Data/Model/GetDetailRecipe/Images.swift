//
//  Images.swift
//  CuisineRecipe
//
//  Created by mac on 4/24/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import Foundation

struct Images: Codable {
    let hostedLargeUrl: String?
    let hostedSmallUrl: String?
    
    enum CodingKeys: String, CodingKey {
        
        case hostedLargeUrl
        case hostedSmallUrl 
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        hostedLargeUrl = try values.decodeIfPresent(String.self, forKey: .hostedLargeUrl)
        hostedSmallUrl = try values.decodeIfPresent(String.self, forKey: .hostedSmallUrl)
    }
}
