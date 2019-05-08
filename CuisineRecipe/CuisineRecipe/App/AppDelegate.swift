//
//  AppDelegate.swift
//  CuisineRecipe
//
//  Created by mac on 4/22/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configTabBar()
        return true
    }
    
    func configTabBar() {
        UITabBar.appearance().tintColor = Colors.tabBarColor
        UITabBar.appearance().backgroundColor = .white
    }
}

