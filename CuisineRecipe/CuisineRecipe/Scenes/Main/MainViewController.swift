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
    
    @IBOutlet private weak var containerView: UIView!
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private lazy var categoryViewController: CategoryViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var vc = storyboard.instantiateViewController(withIdentifier: "CategoryController") as! CategoryViewController
        addChild(vc)
        return vc
    }()
    
    private lazy var searchViewController: SearchViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var vc = storyboard.instantiateViewController(withIdentifier: "SearchController") as! SearchViewController
        addChild(vc)
        return vc
    }()
    
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        containerView.addSubview(viewController.view)
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
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
        remove(asChildViewController: searchViewController)
        add(asChildViewController: categoryViewController)
        searchBar.resignFirstResponder()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        guard let isNavBarHidden = navigationController?.isNavigationBarHidden else { return true }
        if !isNavBarHidden {
            remove(asChildViewController: categoryViewController)
            add(asChildViewController: searchViewController)
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
