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
    
    init(hostedLargeUrl: String?, hostedSmallUrl: String?) {
        if hostedLargeUrl == nil {
            self.hostedLargeUrl = "default_image"
        } else {
            self.hostedLargeUrl = hostedLargeUrl
        }
        
        if hostedSmallUrl == nil {
            self.hostedSmallUrl = "default_image"
        } else {
            self.hostedSmallUrl = hostedSmallUrl
        }
    }
}
