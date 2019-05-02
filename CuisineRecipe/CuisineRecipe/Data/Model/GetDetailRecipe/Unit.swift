//
//  Unit.swift
//  CuisineRecipe
//
//  Created by mac on 4/24/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import Foundation

struct Unit: Codable {
    let id: String?
    let name: String?
    let abbreviation: String?
    let plural: String?
    let pluralAbbreviation: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case abbreviation
        case plural
        case pluralAbbreviation
    }
}
