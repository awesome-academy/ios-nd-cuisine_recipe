//
//  IngredientMO+CoreDataProperties.swift
//  CuisineRecipe
//
//  Created by mac on 5/6/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//
//

import Foundation
import CoreData

extension IngredientMO {
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<IngredientMO> {
        return NSFetchRequest<IngredientMO>(entityName: "Ingredient")
    }

    @NSManaged public var ingredientName: String?
    @NSManaged public var unit: Int32
    @NSManaged public var isBought: Bool
    @NSManaged public var recipe: RecipeMO?

    static func insertNewIngredient(ingredientName: String, unit: Int32, isBought: Bool) -> IngredientMO? {
        guard let moc = AppDelegate.managedObjectContext else { return nil }
        let ingredient = NSEntityDescription.insertNewObject(forEntityName: "Ingredient",
                                                             into: moc) as! IngredientMO
        ingredient.ingredientName = ingredientName
        ingredient.unit = unit
        ingredient.isBought = isBought
        
        do {
            try moc.save()
        } catch {
            let nserror = error as NSError
            print("Cannot save Core Data. Error is: \(nserror), \(nserror.userInfo)")
            return nil
        }
        
        print("Insert ingredient with name: \(ingredient.ingredientName ?? "") successful")
        return ingredient
    }
}
