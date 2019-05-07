//
//  PersistenceService.swift
//  CuisineRecipe
//
//  Created by mac on 5/7/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import CoreData

final class CoreDataManager {
    private init() {}
    
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack
    
   static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CuisineRecipe")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

