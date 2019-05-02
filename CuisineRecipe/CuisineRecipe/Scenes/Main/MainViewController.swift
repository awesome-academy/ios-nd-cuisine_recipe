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
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var containerHomeView: UIView!
    @IBOutlet private weak var containerSearchView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        configView()
    }
    
    func configView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        containerSearchView.isHidden = true
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text?.trimmingCharacters(in: .whitespaces) else { return }
        if searchText.isEmpty {
            showAlert(message: ErrorMessages.recipeNameEmpty)
            return
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        containerSearchView.isHidden = true
        searchBar.resignFirstResponder()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        guard let isNavBarHidden = navigationController?.isNavigationBarHidden else { return true }
        if !isNavBarHidden {
            containerSearchView.isHidden = false
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
        return true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
}
