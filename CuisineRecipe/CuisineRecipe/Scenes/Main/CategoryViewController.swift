//
//  HomeViewController.swift
//  CuisineRecipe
//
//  Created by mac on 4/26/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import UIKit

enum Categories: String {
    case pasta = "Pasta"
    case mainDishes = "Main Dishes"
    case asian = "Asian"
    case drink = "Drink"
    case meatless = "Meatless"
    case dessert = "Dessert"
    case allRecipes = "All Recipes"
}

final class CategoryViewController: UIViewController {
    
    @IBOutlet private weak var viewPasta: UIView!
    @IBOutlet private weak var viewMainDishes: UIView!
    @IBOutlet private weak var viewAsian: UIView!
    @IBOutlet private weak var viewDrink: UIView!
    @IBOutlet private weak var viewMeatless: UIView!
    @IBOutlet private weak var viewDessert: UIView!
    @IBOutlet private weak var viewAllRecipes: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestureRecognizer()
    }
    
    func setupGestureRecognizer() {
        let tapViewPasta = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        viewPasta.addGestureRecognizer(tapViewPasta)
        let tapViewMainDishes = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        viewMainDishes.addGestureRecognizer(tapViewMainDishes)
        let tapViewAsian = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        viewAsian.addGestureRecognizer(tapViewAsian)
        let tapViewDrink = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        viewDrink.addGestureRecognizer(tapViewDrink)
        let tapViewMeatless = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        viewMeatless.addGestureRecognizer(tapViewMeatless)
        let tapViewDessert = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        viewDessert.addGestureRecognizer(tapViewDessert)
        let tapViewAllRecipes = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        viewAllRecipes.addGestureRecognizer(tapViewAllRecipes)
    }
    
    @objc
    func handleTap(sender: UIGestureRecognizer) {
        var searchText: String?
        switch sender.view?.tag {
        case 0:
            searchText = Categories.pasta.rawValue
        case 1:
            searchText = Categories.mainDishes.rawValue
        case 2:
            searchText = Categories.asian.rawValue
        case 3:
            searchText = Categories.drink.rawValue
        case 4:
            searchText = Categories.meatless.rawValue
        case 5:
            searchText = Categories.dessert.rawValue
        default:
            searchText = Categories.allRecipes.rawValue
        }
        
        //swiftlint:disable:next line_length
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "SearchByCategoryVC") as? SearchByCategoryVC else { return }
        vc.navigationItem.title = searchText
        navigationController?.pushViewController(vc, animated: true)
    }
}
