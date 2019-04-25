//
//  APIUrls.swift
//  CuisineRecipe
//
//  Created by mac on 4/25/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import Foundation

enum Urls {
    static let getRecipesList = "http://api.yummly.com/v1/api/recipes?_app_id=\(APIKey.appId)&_app_key=\(APIKey.apiKey)"
    static let recipeInfo = "http://api.yummly.com/v1/api/recipe/"
}
