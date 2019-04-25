//
//  BaseRequest.swift
//  CuisineRecipe
//
//  Created by mac on 4/25/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import Alamofire

typealias JSONDictionary = [String: Any]

class BaseRequest {
    var url = ""
    var requestType = Alamofire.HTTPMethod.get
    var parameters: [String: Any]?
    
    init(url: String) {
        self.url = url
    }
    
    init(url: String, requestType: Alamofire.HTTPMethod) {
        self.url = url
        self.requestType = requestType
    }
    
    init(url: String, requestType: Alamofire.HTTPMethod, parameters: [String: Any]?) {
        self.url = url
        self.requestType = requestType
        self.parameters = parameters
    }
    
    var encoding: ParameterEncoding {
        switch requestType {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
}
