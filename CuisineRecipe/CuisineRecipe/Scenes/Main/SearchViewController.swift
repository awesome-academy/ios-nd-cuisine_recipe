//
//  SearchViewController.swift
//  CuisineRecipe
//
//  Created by mac on 4/26/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let repoRepository = RecipesRepositoryImpl(api: APIService.shared)
    private var recipes: [Recipe] = []
    private var bottomSpinner = CustomSpinner(frame: CGRect.zero)
    private var startIndex = 0
    var searchText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func configView() {
        hideKeyboardWhenTappedAround()
        collectionView.createLayoutCollectionView(viewSize: view.frame.size)
    }
    
    func fetchData() {
        guard let searchText = searchText else { return }
        
        if searchText.isEmptyOrWhitespace() {
            showAlert(message: ErrorMessages.recipeNameEmpty)
            return
        }
        
        repoRepository.fetchRecipes(searchText: searchText, startIndex: startIndex) { result in
            self.dismissLoaddingView()
            self.bottomSpinner.startAnimating()
            switch result {
            case .success(let response):
                guard let data = response?.recipes else { return }
                self.recipes = data
                self.collectionView.reloadData()
            case .failure(let error):
                self.bottomSpinner.stopAnimating()
                self.showError(message: error?.errorMessage)
            }
        }
    }
    
    func clearData() {
        recipes = []
        collectionView.reloadData()
        bottomSpinner.stopAnimating()
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SearchCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setContent(recipe: recipes[indexPath.item])
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == recipes.count - 1 {
            startIndex += Constants.numberOfItems
            loadMore(offset: startIndex)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            //swiftlint:disable:next line_length
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath)
            footerView.addSubview(bottomSpinner)
            return footerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 200, height: 50)
    }
    
    func loadMore(offset: Int) {
        guard let searchText = searchText else {
            return
        }
        
        self.bottomSpinner.startAnimating()
        repoRepository.fetchRecipes(searchText: searchText, startIndex: offset) { result in
            switch result {
            case .success(let response):
                guard let data = response?.recipes else { return }
                for item in data {
                    self.recipes.append(item)
                }
                self.collectionView.reloadData()
            case .failure(let error):
                self.bottomSpinner.stopAnimating()
                self.showError(message: error?.errorMessage)
            }
        }
    }
}

extension SearchViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
