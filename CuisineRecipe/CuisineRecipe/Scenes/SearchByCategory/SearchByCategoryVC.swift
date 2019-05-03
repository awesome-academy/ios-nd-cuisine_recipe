//
//  SearchByCategoryVC.swift
//  CuisineRecipe
//
//  Created by mac on 5/2/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import UIKit

final class SearchByCategoryVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    private let repoRepository = RecipesRepositoryImpl(api: APIService.shared)
    var recipes: [Recipe] = []
    let shimmerView = ShimmerView(frame: Screen.bounds)
    var spinner = CustomSpinner(frame: CGRect.zero)
    var offset = 0
    var reachedEndOfItems = false
    var searchText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func configView() {
        hideKeyboardWhenTappedAround()
        navigationItem.largeTitleDisplayMode = .never
        collectionView.createLayoutCollectionView(viewSize: view.frame.size)
        view.addSubview(shimmerView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func fetchData() {
        guard let searchText = searchText else { return }
        
        if searchText.isEmptyOrWhitespace() {
            showAlert(message: ErrorMessages.recipeNameEmpty)
            return
        }
        
        shimmerView.alpha = 1.0
        repoRepository.fetchRecipes(searchText: searchText, startIndex: offset) { result in
            self.shimmerView.alpha = 0.0
            self.spinner.startAnimating()
            switch result {
            case .success(let response):
                guard let data = response?.recipes else { return }
                self.recipes = data
                self.collectionView.reloadData()
            case .failure(let error):
                self.spinner.stopAnimating()
                self.showError(message: error?.errorMessage)
            }
        }
    }
}

extension SearchByCategoryVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SearchCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setContent(recipe: recipes[indexPath.item])
        return cell
    }
}

extension SearchByCategoryVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == recipes.count - 1 {
            offset += 10
            loadMore(offset: offset)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            //swiftlint:disable:next line_length
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath)
            footerView.addSubview(spinner)
            return footerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 200, height: 50)
    }
    
    func loadMore(offset: Int) {
        guard !self.reachedEndOfItems, let searchText = searchText else {
            return
        }
        
        self.spinner.startAnimating()
        repoRepository.fetchRecipes(searchText: searchText, startIndex: offset) { result in
            switch result {
            case .success(let response):
                guard let data = response?.recipes else { return }
                for item in data {
                    self.recipes.append(item)
                }
                self.collectionView.reloadData()
            case .failure(let error):
                self.spinner.stopAnimating()
                self.showError(message: error?.errorMessage)
            }
        }
    }
}

extension SearchByCategoryVC: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
