//
//  HomeViewController.swift
//  CuisineRecipe
//
//  Created by mac on 4/26/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import UIKit

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
        let listView = [viewPasta, viewMainDishes, viewAsian, viewDrink, viewMeatless, viewDessert, viewAllRecipes]
        listView.enumerated().forEach { index, view in
            let myTapGestureRecognizer = CustomGestureRecognizer(target: self, action: #selector(handleTap))
            view?.addGestureRecognizer(myTapGestureRecognizer)
            myTapGestureRecognizer.title = Constants.arrRecipeType[index]
        }
    }
    
    @objc
    func handleTap(sender: CustomGestureRecognizer) {
        let vc = SearchByCategoryVC.instantiate()
        vc.setTitleNavigationBar(title: sender.title)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CategoryViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
