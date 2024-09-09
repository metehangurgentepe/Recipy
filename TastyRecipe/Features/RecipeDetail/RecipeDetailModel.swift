
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let recipeDetailModel = try? JSONDecoder().decode(RecipeDetailModel.self, from: jsonData)

import Foundation

// MARK: - RecipeDetailModel
struct RecipeDetailModel: Codable {
    let vegetarian, vegan, glutenFree, dairyFree: Bool?
    let veryHealthy, cheap, veryPopular, sustainable: Bool?
    let lowFodmap: Bool?
    let preparationMinutes, cookingMinutes: Int?
    let creditsText, license, sourceName: String?
    let pricePerServing: Double?
    let extendedIngredients: [ExtendedIngredient]?
    let id: Int?
    let title: String?
    let readyInMinutes, servings: Int?
    let sourceURL: String?
    let image: String?
    let imageType, summary: String?
    let dishTypes, diets, occasions: [String]?
    let instructions: String?
    let analyzedInstructions: [AnalyzedInstruction]?
    let spoonacularScore: Double?
    let spoonacularSourceURL: String?
}

// MARK: - AnalyzedInstruction
struct AnalyzedInstruction: Codable {
    let name: String?
    let steps: [Step]?
}

// MARK: - Step
struct Step: Codable {
    let number: Int?
    let step: String?
    let ingredients: [Ent]?
    let length: Length?
}

// MARK: - Ent
struct Ent: Codable {
    let id: Int?
    let name, localizedName: String?
}

// MARK: - Length
struct Length: Codable {
    let number: Int?
    let unit: String?
}

// MARK: - ExtendedIngredient
struct ExtendedIngredient: Codable {
    let id: Int?
    let aisle, image, consistency, name: String?
    let nameClean, original, originalName: String?
    let amount: Double?
    let unit: String?
    let measures: Measures?
}

// MARK: - Measures
struct Measures: Codable {
    let us, metric: Metric?
}

// MARK: - Metric
struct Metric: Codable {
    let amount: Double?
    let unitShort, unitLong: String?
}
