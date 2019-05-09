//
//  DetailRecipeViewController.swift
//  CuisineRecipe
//
//  Created by mac on 5/4/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import UIKit

final class DetailRecipeViewController: UIViewController {
    @IBOutlet private weak var starRatingStackView: StarRating!
    @IBOutlet private weak var preparingTimeLabel: UILabel!
    @IBOutlet private weak var cookingTimeLabel: UILabel!
    @IBOutlet private weak var totalTimeLabel: UILabel!
    @IBOutlet private weak var numberOfServingsLabel: UILabel!
    @IBOutlet private weak var nutritionCollectionView: UICollectionView!
    @IBOutlet private weak var recipeImageViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var recipeNameLabel: UILabel!
    @IBOutlet private weak var ingredientsTableView: UITableView!
    @IBOutlet private weak var recipeImageView: UIImageView!
    @IBOutlet private weak var recipeImageViewTopConstraint: NSLayoutConstraint!
    
    private let repoRepository = RecipesRepositoryImpl(api: APIService.shared)
    private var originalHeight: CGFloat!
    private var recipeInfo: RecipeInfoResponse?
    var recipeId: String?
    fileprivate var imagePickerController: UIImagePickerController!
    
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
        configNavigationBar(image: UIImage(), color: .white, isHideNavigationBar: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        configNavigationBar(image: nil, color: Colors.primaryColor, isHideNavigationBar: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func configNavigationBar(image: UIImage?, color: UIColor, isHideNavigationBar: Bool) {
        navigationController?.setNavigationBarHidden(isHideNavigationBar, animated: true)
        navigationController?.navigationBar.setBackgroundImage(image, for: .default)
        navigationController?.navigationBar.shadowImage = image
        navigationController?.navigationBar.tintColor = color
    }

    fileprivate func configView() {
        scrollView.delegate = self
        originalHeight = recipeImageViewHeight.constant
        ingredientsTableView.tableFooterView = UITableViewHeaderFooterView()
        recipeImageView.setupGradientBarBottom(width: view.frame.width, height: recipeImageView.frame.height)
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
    }
    
    fileprivate func fetchData() {
        guard let recipeId = recipeId else { return }
        repoRepository.fetchRecipeInfo(recipeId: recipeId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                guard let data = response,
                    let img = data.images,
                    let rating = data.rating else { return }
                guard !img.isEmpty, let imgUrl = img[0].hostedLargeUrl else { return }
                
                self.recipeInfo = data
                self.recipeImageView.loadImageFromUrl(urlString: imgUrl)
                self.recipeNameLabel.text = data.name
                self.numberOfServingsLabel.text?.append(String(data.numberOfServings))
                
                if let cookingTime = data.cookTime {
                    self.cookingTimeLabel.text = cookingTime.isEmptyOrWhitespace() ? "0 minute" : cookingTime
                } else {
                    self.cookingTimeLabel.text = "0 minute"
                }
                
                if let prepareTime = data.prepTime {
                    self.preparingTimeLabel.text = (prepareTime.isEmptyOrWhitespace()) ? "0 minute" : data.prepTime
                } else {
                    self.preparingTimeLabel.text = "0 minute"
                }
            
                self.totalTimeLabel.text = data.totalTime
                self.starRatingStackView.setupButtons(starCount: rating)
                
                self.ingredientsTableView.reloadData()
                self.nutritionCollectionView.reloadData()
            case .failure(let error):
                self.showError(message: error?.errorMessage)
            }
        }
    }
    
    @IBAction private func handleAddShoppingListTapped(_ sender: Any) {
        guard let recipeInfo = recipeInfo,
            let img = recipeInfo.images,
            !img.isEmpty,
            let imgUrl = img[0].hostedLargeUrl else { return }
        
        guard !RecipeMO.shared.recipeExists(recipeId: recipeId) else {
            showToast(message: ToastMessage.recipeExists)
            return
        }
        
        let recipe = RecipeMO.shared.insertRecipe(id: recipeInfo.id,
                                                  recipeName: recipeInfo.name,
                                                  imageUrl: imgUrl,
                                                  numOfServings: Int32(recipeInfo.numberOfServings))
        
        guard let ingredientLines = recipeInfo.ingredientLines else { return }
        var ingredients = Set<IngredientMO>()
        
        guard !ingredientLines.isEmpty else { return }
        for item in ingredientLines {
            guard let ingredient = IngredientMO.shared.insertIngredient(ingredientName: item,
                                                                        unit: 1,
                                                                        isBought: false) else { return }
            ingredient.recipe = recipe
            ingredients.insert(ingredient)
        }
        
        recipe?.addToIngredients(ingredients as NSSet)
        showToast(message: ToastMessage.addRecipeSuccessful)
    }
    
    @IBAction private func handleSnapTapped(_ sender: Any) {
        if checkPermission(completion: { message in
            self.showAlert(message: message)
        }) {
            setupActionSheet()
        }
    }
}

extension DetailRecipeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let defaultTop: CGFloat = 0.0
        var currentTop = defaultTop
        if scrollView == self.scrollView {
            if offset < 0 {
                currentTop = offset
                recipeImageViewHeight.constant = originalHeight - offset
            } else {
                recipeImageViewHeight.constant = originalHeight
            }
            recipeImageViewTopConstraint.constant = currentTop
        }
    }
}

extension DetailRecipeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeInfo?.ingredientLines?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let recipeInfo = recipeInfo,
            let ingredient = recipeInfo.ingredientLines?[indexPath.row] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        cell.textLabel?.textColor = Colors.textColor
        cell.textLabel?.text = ingredient
        return cell
    }
}

extension DetailRecipeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipeInfo?.nutritionEstimates?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let nutriData = recipeInfo?.nutritionEstimates else { return UICollectionViewCell() }
        let cell: DetailRecipeCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure(nutri: nutriData[indexPath.item])
        return cell
    }
}

extension DetailRecipeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    fileprivate func setupActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        //ActionSheet Camera
        actionSheet.addAction(UIAlertAction(title: ImageSource.camera.rawValue,
                                            style: .default,
                                            handler: { _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.selectImageFrom(.camera)
            } else {
                self.showAlert(message: ErrorMessages.cameraNotAvailable)
            }
        }))
        
        //ActionSheet Photo Library
        actionSheet.addAction(UIAlertAction(title: ImageSource.photoLibrary.rawValue,
                                            style: .default,
                                            handler: { _ in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                self.selectImageFrom(.photoLibrary)
            } else {
                self.showAlert(message: ErrorMessages.photoLibNotAvailable)
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    private func selectImageFrom(_ source: ImageSource) {
        switch source {
        case .camera:
            imagePickerController.sourceType = .camera
        case .photoLibrary:
            imagePickerController.sourceType = .photoLibrary
        }
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            print("Cannot found image")
            return
        }
        picker.dismiss(animated: true, completion: nil)
        
        let vc = ShareViewController.instantiate()
        vc.achievementImage = image
        let navController = UINavigationController(rootViewController: vc)
        present(navController, animated: true, completion: nil)
    }
    
    private func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension DetailRecipeViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
