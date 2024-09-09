//
//  RecipeDetailViewDelegate.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 4.09.2024.
//

import Foundation

protocol RecipeDetailViewDelegate: AnyObject {
    func getDetail(recipe: RecipeDetailModel)
    func getSimilarRecipes(recipes: [RecipeDetailModel])
    func showError(_ error: Error)
    func didSelectRecipe(recipeId: Int)
}
