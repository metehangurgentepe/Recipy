//
//  Recipe.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 3.09.2024.
//

import Foundation

struct RecipeResponse: Codable, Hashable {
    var results: [Recipe]
    var offset: Int
    var number: Int
    var totalResults: Int
    
    static func == (lhs: RecipeResponse, rhs: RecipeResponse) -> Bool {
        return lhs.results == rhs.results &&
        lhs.offset == rhs.offset &&
        lhs.number == rhs.number &&
        lhs.totalResults == rhs.totalResults
    }
}

struct Recipe: Codable, Hashable {
    var id: Int
    var title: String
    var image: String
    var imageType: String
}
