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
        let parameters: [String: Any] = [
            "_app_id": APIKey.appId,
            "_app_key": APIKey.apiKey
        ]
    
        super.init(url: Urls.recipeInfo + recipeId, requestType: .get, parameters: parameters)
    }
}
