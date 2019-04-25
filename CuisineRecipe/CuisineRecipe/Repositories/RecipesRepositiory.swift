//
//  RecipesRepositiory.swift
//  CuisineRecipe
//
//  Created by mac on 4/25/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

protocol RecipesRepository {
    func fetchRecipes(searchText: String, startIndex: Int, completion: @escaping (BaseResult<RecipesResponse>) -> Void)
    
    func fetchRecipeInfo(recipeId: String, completion: @escaping (BaseResult<RecipeInfoResponse>) -> Void)
}

final class RecipesRepositoryImpl: RecipesRepository {
    
    private var api: APIService?
    
    required init(api: APIService) {
        self.api = api
    }
    
    func fetchRecipes(searchText: String, startIndex: Int, completion: @escaping (BaseResult<RecipesResponse>) -> Void) {
        let input = GetRecipesRequest(searchText: searchText, startIndex: startIndex)
        
        api?.request(input: input) { (object: RecipesResponse?, error) in
            if let object = object {
                completion(.success(object))
            } else if let error = error {
                completion(.failure(error: error))
            } else {
                completion(.failure(error: nil))
            }
        }
    }
    
    func fetchRecipeInfo(recipeId: String, completion: @escaping (BaseResult<RecipeInfoResponse>) -> Void) {
        let input = RecipeInfoRequest(recipeId: recipeId)
        
        api?.request(input: input) { (object: RecipeInfoResponse?, error) in
            if let object = object {
                completion(.success(object))
            } else if let error = error {
                completion(.failure(error: error))
            } else {
                completion(.failure(error: nil))
            }
        }
    }
}
