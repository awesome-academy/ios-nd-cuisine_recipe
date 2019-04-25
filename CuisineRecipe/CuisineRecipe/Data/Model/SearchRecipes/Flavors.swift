//
//  Flavors.swift
//  CuisineRecipe
//
//  Created by mac on 4/24/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import Foundation

struct Flavors: Codable {
    let salty: Double?
    let sour: Double?
    let sweet: Double?
    let bitter: Double?
    let meaty: Double?
    let piquant: Double?
    
    enum CodingKeys: String, CodingKey {
        
        case salty
        case sour
        case sweet
        case bitter
        case meaty
        case piquant
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        salty = try values.decodeIfPresent(Double.self, forKey: .salty)
        sour = try values.decodeIfPresent(Double.self, forKey: .sour)
        sweet = try values.decodeIfPresent(Double.self, forKey: .sweet)
        bitter = try values.decodeIfPresent(Double.self, forKey: .bitter)
        meaty = try values.decodeIfPresent(Double.self, forKey: .meaty)
        piquant = try values.decodeIfPresent(Double.self, forKey: .piquant)
    }
}
