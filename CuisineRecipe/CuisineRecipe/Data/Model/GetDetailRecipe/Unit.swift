//
//  Unit.swift
//  CuisineRecipe
//
//  Created by mac on 4/24/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import Foundation

struct Unit: Codable {
    let name: String?
    let abbreviation: String?
    let plural: String?
    let pluralAbbreviation: String?
    
    enum CodingKeys: String, CodingKey {
        
        case name
        case abbreviation
        case plural
        case pluralAbbreviation
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        abbreviation = try values.decodeIfPresent(String.self, forKey: .abbreviation)
        plural = try values.decodeIfPresent(String.self, forKey: .plural)
        pluralAbbreviation = try values.decodeIfPresent(String.self, forKey: .pluralAbbreviation)
    }
}
