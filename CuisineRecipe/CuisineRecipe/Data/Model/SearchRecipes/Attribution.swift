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
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        html = try values.decodeIfPresent(String.self, forKey: .html)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        logo = try values.decodeIfPresent(String.self, forKey: .logo)
    }
}
