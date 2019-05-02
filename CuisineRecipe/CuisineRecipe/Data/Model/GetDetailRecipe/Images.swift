//
//  Images.swift
//  CuisineRecipe
//
//  Created by mac on 4/24/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import Foundation

struct Images: Codable {
    let hostedSmallUrl: String?
    let hostedMediumUrl: String?
    let hostedLargeUrl: String?
    let imageUrlsBySize: ImageUrlsBySize?
    
    enum CodingKeys: String, CodingKey {
        case hostedSmallUrl
        case hostedMediumUrl
        case hostedLargeUrl
        case imageUrlsBySize 
    }
}
