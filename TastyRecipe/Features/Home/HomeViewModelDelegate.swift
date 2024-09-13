//
//  HomeViewModelDelegate.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 3.09.2024.
//

import Foundation

protocol HomeViewDelegate: AnyObject {
    func refreshCollectionView(recipes: [Recipe])
    func showError(_ error: Error)
    func refreshRecentCollectionView(recipes: [Recipe])
}
