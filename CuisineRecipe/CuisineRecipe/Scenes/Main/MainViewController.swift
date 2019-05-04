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
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var containerHomeView: UIView!
    @IBOutlet private weak var containerSearchView: UIView!
    
    private lazy var categoryViewController: CategoryViewController = {
        let vc = CategoryViewController.instantiate()
        addChild(vc)
        return vc
    }()
    
    private lazy var searchViewController: SearchViewController = {
        let vc = SearchViewController.instantiate()
        addChild(vc)
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func configView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        containerSearchView.isHidden = true
        searchBar.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
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
        
        showLoaddingView()
        searchViewController.searchText = searchText
        searchViewController.fetchData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        remove(asChildViewController: searchViewController)
        add(asChildViewController: categoryViewController)
        searchBar.resignFirstResponder()
        searchViewController.clearData()
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
