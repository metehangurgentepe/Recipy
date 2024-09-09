//
//  SearchRecipeDetailModel.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 8.09.2024.
//

import Foundation

struct SearchRecipeDetailModel: Codable {
    let count: Int?
    let results: [SearchRecipeResult]?
}

struct SearchRecipeResult: Codable {
    let cookTimeMinutes: Int?
    let description: String?
    let id: Int?
    let name: String?
    let numServings: Int?
    let prepTimeMinutes: Int?
    let totalTimeMinutes: Int?
    let thumbnailURL: String?
    
    enum CodingKeys: String, CodingKey {
        case cookTimeMinutes = "cook_time_minutes"
        case description
        case id
        case name
        case numServings = "num_servings"
        case prepTimeMinutes = "prep_time_minutes"
        case totalTimeMinutes = "total_time_minutes"
        case thumbnailURL = "thumbnail_url"
    }
}
