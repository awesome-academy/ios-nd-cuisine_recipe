//
//  CustomRequestAdapter.swift
//  CuisineRecipe
//
//  Created by mac on 4/25/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import Alamofire

final class CustomRequestAdapter: RequestAdapter {
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
}
