//
//  Matches.swift
//  CuisineRecipe
//
//  Created by mac on 4/24/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import Foundation

struct Matches: Codable {
    let attributes: Attributes?
    let flavors: Flavors?
    let rating: Double?
    let id: String?
    let smallImageUrls: [String]?
    let sourceDisplayName: String?
    let totalTimeInSeconds: Int?
    let ingredients: [String]?
    let recipeName: String?
    
    enum CodingKeys: String, CodingKey {
        
        case attributes
        case flavors
        case rating
        case id
        case smallImageUrls
        case sourceDisplayName
        case totalTimeInSeconds
        case ingredients
        case recipeName 
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        attributes = try values.decodeIfPresent(Attributes.self, forKey: .attributes)
        flavors = try values.decodeIfPresent(Flavors.self, forKey: .flavors)
        rating = try values.decodeIfPresent(Double.self, forKey: .rating)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        smallImageUrls = try values.decodeIfPresent([String].self, forKey: .smallImageUrls)
        sourceDisplayName = try values.decodeIfPresent(String.self, forKey: .sourceDisplayName)
        totalTimeInSeconds = try values.decodeIfPresent(Int.self, forKey: .totalTimeInSeconds)
        ingredients = try values.decodeIfPresent([String].self, forKey: .ingredients)
        recipeName = try values.decodeIfPresent(String.self, forKey: .recipeName)
    }
}

