//
//  ShoppingListViewController.swift
//  CuisineRecipe
//
//  Created by mac on 5/6/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import UIKit

final class ShoppingListViewController: UIViewController {
    @IBOutlet private weak var recipesTableView: UITableView!
    
    private var recipes: [RecipeMO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    fileprivate func configView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        recipesTableView.tableFooterView = UITableViewHeaderFooterView()
        recipesTableView.rowHeight = 96
    }
    
    fileprivate func fetchData() {
        recipes = RecipeMO.getAllRecipes().sorted {
            guard let recipeName1 = $0.recipeName,
                let recipeName2 = $1.recipeName else { return false }
            return recipeName1 < recipeName2
        }
        recipesTableView.reloadData()
    }
}

extension ShoppingListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ShoppingListViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(recipe: recipes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            guard indexPath.row < recipes.count,
                let recipeId = recipes[indexPath.row].id else { return }
            
            if RecipeMO.deleteRecipe(recipeId: recipeId) {
                recipes.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.item < recipes.count {
            let vc = DetailShoppingListViewController.instantiate()
            vc.recipe = recipes[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
