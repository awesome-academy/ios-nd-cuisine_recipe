//
//  Attribution.swift
//  CuisineRecipe
//
//  Created by mac on 4/24/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import Foundation

struct Attribution: Codable {
    let html: String?
    let url: String?
    let text: String?
    let logo: String?
    
    enum CodingKeys: String, CodingKey {
        case html
        case url
        case text
        case logo 
    }
}
