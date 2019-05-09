//
//  Constants.swift
//  CuisineRecipe
//
//  Created by mac on 5/2/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

enum Constants {
    static let arrRecipeType = ["Pasta", "Main Dishes", "Asian", "Drink", "Meatless", "Dessert", "All Recipes"]
    static var numberOfItems = 10
    static let descriptionPlaceholder = "Let inspiring all with your achievement!"
}

enum Colors {
    static let primaryColor = UIColor(hexString: "464646")
    static let textColor = UIColor(hexString: "067F78")
    static let tabBarColor = UIColor(hexString: "666")
    static let toastBackgroundColor = UIColor(hexString: "C0C0C0")
}

enum ErrorMessages {
    static let recipeNameEmpty = "Please enter the recipe you're looking for."
    static let deleteRecipeUnsuccessful = "Delete recipe unsuccessful"
    static let recipeIdEmpty = "The recipe does not has identifier"
    static let cameraNotAvailable = "Camera not available"
    static let photoLibNotAvailable = "Photo Library cannot be accessed"
}

enum ToastMessage {
    static let recipeExists = "You have added this recipe to shopping list"
    static let addRecipeSuccessful = "You add the recipe to shopping list successful!"
}

enum ImageSource: String {
    case camera = "Take a photo"
    case photoLibrary = "Choose a photo"
}
