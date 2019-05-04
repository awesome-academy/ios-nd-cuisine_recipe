//
//  DetailRecipeViewController.swift
//  CuisineRecipe
//
//  Created by mac on 5/4/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import UIKit

final class DetailRecipeViewController: UIViewController {
    @IBOutlet private weak var StarRating: StarRating!
    @IBOutlet private weak var lblPreparingTime: UILabel!
    @IBOutlet private weak var lblCookingTime: UILabel!
    @IBOutlet private weak var lblTotalTime: UILabel!
    @IBOutlet private weak var numberOfServings: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var imageViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var titleName: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var imageViewTopConstraint: NSLayoutConstraint!
    
    private let repoRepository = RecipesRepositoryImpl(api: APIService.shared)
    private var originalHeight: CGFloat!
    private var recipeInfo: RecipeInfoResponse?
    var recipeId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        fetchData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.tintColor = UIColor(hexString: "464646")
    }
    
    func configView() {
        scrollView.delegate = self
        originalHeight = imageViewHeight.constant
        tableView.tableFooterView = UITableViewHeaderFooterView()
        imageView.setupGradientBarBottom(width: imageView.frame.width, height: imageView.frame.height)
    }
    
    func fetchData() {
        guard let recipeId = recipeId else { return }
        repoRepository.fetchRecipeInfo(recipeId: recipeId) { result in
            switch result {
            case .success(let response):
                guard let data = response,
                    let imgUrl = data.images?[0].hostedLargeUrl,
                    let numOfServings = data.numberOfServings,
                    let rating = data.rating else { return }
                
                self.recipeInfo = data
                self.imageView.loadImageFromUrl(urlString: imgUrl)
                self.titleName.text = data.name
                self.lblCookingTime.text = self.recipeInfo?.cookTime ?? self.recipeInfo?.totalTime
                self.numberOfServings.text?.append(String(numOfServings))
                
                if let prepareTime = data.prepTime {
                    self.lblPreparingTime.text = (prepareTime.isEmptyOrWhitespace()) ? "0 min" : data.prepTime
                } else {
                    self.lblPreparingTime.text = "0 min"
                }
            
                self.lblTotalTime.text = data.totalTime
                self.StarRating.setupButtons(starCount: rating)
                
                self.tableView.reloadData()
                self.collectionView.reloadData()
            case .failure(let error):
                self.showError(message: error?.errorMessage)
            }
        }
    }
}

extension DetailRecipeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let defaultTop: CGFloat = 0.0
        var currentTop = defaultTop
        if offset < 0 {
            currentTop = offset
            imageViewHeight.constant = originalHeight - offset
        } else {
            imageViewHeight.constant = originalHeight
        }
        imageViewTopConstraint.constant = currentTop
    }
}

extension DetailRecipeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeInfo?.ingredientLines?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        guard let recipeInfo = recipeInfo,
            let ingredient = recipeInfo.ingredientLines?[indexPath.row] else { return UITableViewCell() }
        cell.textLabel?.textColor = UIColor(hexString: "067F78")
        cell.textLabel?.text = ingredient
        return cell
    }
}

extension DetailRecipeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipeInfo?.nutritionEstimates?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DetailRecipeCell = collectionView.dequeueReusableCell(for: indexPath)
        guard let nutriData = recipeInfo?.nutritionEstimates else { return UICollectionViewCell() }
        cell.configure(nutri: nutriData[indexPath.item])
        return cell
    }
}

extension DetailRecipeViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
