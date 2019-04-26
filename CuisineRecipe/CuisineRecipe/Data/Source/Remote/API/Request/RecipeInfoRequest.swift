//
//  RecipeInfoRequest.swift
//  CuisineRecipe
//
//  Created by mac on 4/25/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import Foundation
import Alamofire

final class RecipeInfoRequest: BaseRequest {
    
    required init(recipeId: String) {
        super.init(url: Urls.basePath + "recipe/" + recipeId, requestType: .get, parameters: nil)
    }
}
