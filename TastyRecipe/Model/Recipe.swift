//
//  Recipe.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 3.09.2024.
//

import Foundation

struct RecipeResponse: Codable, Hashable {
    let results: [Recipe]
    let offset: Int
    let number: Int
    let totalResults: Int
    
    static func == (lhs: RecipeResponse, rhs: RecipeResponse) -> Bool {
        return lhs.results == rhs.results &&
        lhs.offset == rhs.offset &&
        lhs.number == rhs.number &&
        lhs.totalResults == rhs.totalResults
    }
}

struct Recipe: Codable, Hashable {
    let id: Int
    let title: String
    let image: String
    let imageType: String
}
