//
//  SearchViewDelegate.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 6.09.2024.
//

import Foundation

protocol SearchViewDelegate: AnyObject {
    func refreshCollectionView(recipe: [SearchRecipeResult])
    func showError(_ error: Error)
}
