//
//  SavedRecipeController.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 11.09.2024.
//

import UIKit

class SavedRecipeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let viewModel = ProfileViewModel()
    var recipes: [Recipe] = []
    
    private var emptyView = EmptyStateView(message: "You haven't liked any recipes yet.", image: UIImage(named: "chatbot_image"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emptyView.frame = view.bounds
        view.addSubview(emptyView)
        
        self.collectionView.register(SavedRecipeCell.self, forCellWithReuseIdentifier: SavedRecipeCell.identifier)
        
        view.backgroundColor = ThemeColor.bgColor
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = ThemeColor.bgColor
        
        viewModel.delegate = self
        viewModel.fetchSavedRecipes()
        
        updateEmptyViewVisibility()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SavedRecipeCell.identifier, for: indexPath) as! SavedRecipeCell
        cell.configure(recipe: recipes[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat = 4
        let itemsPerRow: CGFloat = 2
        
        let totalPadding = padding * (itemsPerRow + 1)
        let availableWidth = collectionView.bounds.width - totalPadding
        let widthPerItem = availableWidth / itemsPerRow
        
        let recipe = recipes[indexPath.item]
        let estimatedHeight = estimatedHeightForText(recipe.title, width: widthPerItem)
        
        let height = 130 + 10 + estimatedHeight + 30 + 10
        return CGSize(width: widthPerItem, height: height)
    }
    
    private func estimatedHeightForText(_ text: String, width: CGFloat) -> CGFloat {
        let size = CGSize(width: width, height: .greatestFiniteMagnitude)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .headline).withSize(16)
        ]
        let estimatedFrame = NSString(string: text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return estimatedFrame.height
    }
    
    private func updateEmptyViewVisibility() {
        emptyView.isHidden = !recipes.isEmpty
        collectionView.isHidden = recipes.isEmpty
    }
}

extension SavedRecipeController: ProfileViewModelProtocol {
    func fetchSavedRecipes(recipes: [Recipe]) {
        self.recipes = recipes
        collectionView.reloadData()
        updateEmptyViewVisibility()
    }
    
    func showError(_ error: any Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
