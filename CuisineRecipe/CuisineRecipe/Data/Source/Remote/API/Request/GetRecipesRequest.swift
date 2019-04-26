//
//  GetRecipesRequest.swift
//  CuisineRecipe
//
//  Created by mac on 4/25/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import Foundation
import Alamofire

final class GetRecipesRequest: BaseRequest {
    
    required init(searchText: String, startIndex: Int, perPage: Int = 10) {
        let parameters: [String: Any]  = [
            "q": searchText,
            "maxResult": perPage,
            "start": startIndex
        ]
        
        super.init(url: Urls.basePath + "recipes", requestType: .get, parameters: parameters)
    }
}
