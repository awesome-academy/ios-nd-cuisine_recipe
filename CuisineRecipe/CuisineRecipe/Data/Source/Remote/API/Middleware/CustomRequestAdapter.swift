//
//  CustomRequestAdapter.swift
//  CuisineRecipe
//
//  Created by mac on 4/25/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import Alamofire

final class CustomRequestAdapter: RequestAdapter {
    private var headers = Alamofire.SessionManager.defaultHTTPHeaders
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.setValue(APIKey.appId, forHTTPHeaderField: "X-Yummly-App-ID")
        urlRequest.setValue(APIKey.apiKey, forHTTPHeaderField: "X-Yummly-App-Key")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
}
