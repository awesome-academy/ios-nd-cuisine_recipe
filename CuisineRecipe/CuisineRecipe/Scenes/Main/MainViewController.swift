//
//  ViewController.swift
//  CuisineRecipe
//
//  Created by mac on 4/22/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import UIKit
import Alamofire

final class MainViewController: UIViewController {
    private let repoRepository = RecipesRepositoryImpl(api: APIService.shared)
    var recipes: [Matches] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    private func fetchData() {
        repoRepository.fetchRecipes(searchText: "Slow Cooker Beef Pot Roast", startIndex: 0) { result in
            switch result {
            case .success(let response):
                guard let data = response?.matches else { return }
                self.recipes = data
                print(data)
            case .failure(let error):
                self.showError(message: error?.errorMessage)
            }
        }
    }
}

