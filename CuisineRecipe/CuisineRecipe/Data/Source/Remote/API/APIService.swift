//
//  APIService.swift
//  CuisineRecipe
//
//  Created by mac on 4/25/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import Foundation
import Alamofire

struct APIService {
    static let shared = APIService()
    
    private var alamofireManager = Alamofire.SessionManager.default
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        alamofireManager = Alamofire.SessionManager(configuration: configuration)
        alamofireManager.adapter = CustomRequestAdapter()
    }
    
    func request<T: Decodable>(input: BaseRequest, completion: @escaping (_ value: T?, _ error: BaseError?) -> Void) {
        print(input)
        alamofireManager.request(input.url,
                                 method: input.requestType,
                                 parameters: input.parameters,
                                 encoding: input.encoding)
            .validate(statusCode: 200..<512)
            .responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        if let statusCode = response.response?.statusCode {
                            if statusCode == 200 {
                                print("Success code: [\(statusCode)] " + input.url)
                                
                                guard let responseData = response.data else { return }
                                let object = try JSONDecoder().decode(T.self, from: responseData)
                                completion(object, nil)
                            } else {
                                print("Error code: [\(statusCode)] " + input.url)
                                completion(nil, BaseError.httpError(httpCode: statusCode))
                            }
                        } else {
                            completion(nil, BaseError.unexpectedError)
                        }
                    } catch {
                        completion(nil, BaseError.apiFailure)
                    }
                case .failure:
                    completion(nil, BaseError.networkError)
                }
            }
    }
}
