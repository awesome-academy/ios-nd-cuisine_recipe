//
//  Matches.swift
//  CuisineRecipe
//
//  Created by mac on 4/24/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import Foundation

struct Recipe: Codable {
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
}

