//
//  DetailShoppingListViewController.swift
//  CuisineRecipe
//
//  Created by mac on 5/7/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

final class DetailShoppingListViewController: UIViewController {
    @IBOutlet private weak var recipeImageView: UIImageView!
    @IBOutlet private weak var ingredientsTableView: UITableView!
    @IBOutlet private weak var numOfServingsLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var recipeImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var recipeImageViewTopConstraint: NSLayoutConstraint!
    
    var recipe: RecipeMO?
    fileprivate var originalHeight: CGFloat!
    fileprivate var sortedIngredients: [IngredientMO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    fileprivate func configView() {
        navigationItem.largeTitleDisplayMode = .never
        originalHeight = recipeImageViewHeight.constant
        ingredientsTableView.tableFooterView = UITableViewHeaderFooterView()
    }
    
    @IBAction private func handleGoToRecipeTapped(_ sender: Any) {
        let vc = DetailRecipeViewController.instantiate()
        vc.recipeId = recipe?.id
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func fetchData() {
        navigationItem.title = recipe?.recipeName
        guard let imgUrl = recipe?.imageUrl,
            let numsOfServings = recipe?.numOfServings,
            let ingredients = recipe?.ingredients?.allObjects as? [IngredientMO] else { return }
        
        recipeImageView.loadImageFromUrl(urlString: imgUrl)
        recipeImageView.setupGradientBarBottom(width: view.frame.width, height: recipeImageView.frame.height)
        numOfServingsLabel.text = String(numsOfServings) + " servings"
        sortedIngredients = ingredients.sorted {
            guard let ingredientName1 = $0.ingredientName,
            let ingredientName2 = $1.ingredientName else { return false }
            return ingredientName1 < ingredientName2
        }
    }
    
    @IBAction private func handleRemoveRecipeTapped(_ sender: Any) {
        guard let recipeId = recipe?.id else {
            showError(message: ErrorMessages.recipeIdEmpty)
            return
        }
        
        if RecipeMO.shared.deleteRecipe(recipeId: recipeId) {
            navigationController?.popViewController(animated: true)
        } else {
            showError(message: ErrorMessages.deleteRecipeUnsuccessful)
        }
    }
}

extension DetailShoppingListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let defaultTop = CGFloat(0)
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

extension DetailShoppingListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedIngredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ListIngredientsViewCell = tableView.dequeueReusableCell(for: indexPath)
        let ingredient = sortedIngredients[indexPath.row]
        cell.configure(ingredient: ingredient)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.item < sortedIngredients.count {
            let selectedIngredient = sortedIngredients[indexPath.row]
            guard let ingredientName = selectedIngredient.ingredientName else { return }
            selectedIngredient.isBought = !selectedIngredient.isBought
            guard IngredientMO.shared.updateIngredient(ingredientName: ingredientName,
                                                       isBought: selectedIngredient.isBought) else { return }
            tableView.reloadData()
        }
    }
}

extension DetailShoppingListViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
