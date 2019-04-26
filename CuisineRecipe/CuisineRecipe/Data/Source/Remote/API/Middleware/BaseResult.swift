//
//  BaseResult.swift
//  CuisineRecipe
//
//  Created by mac on 4/25/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

enum BaseResult<T: Decodable> {
    case success(T?)
    case failure(error: BaseError?)
}
