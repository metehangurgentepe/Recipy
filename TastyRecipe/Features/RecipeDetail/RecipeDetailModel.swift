
import Foundation

struct RecipeDetailModel: Codable {
    let vegetarian, vegan, glutenFree, dairyFree: Bool
    let veryHealthy, cheap, veryPopular, sustainable: Bool
    let lowFodmap: Bool
    let aggregateLikes, healthScore: Int
    let pricePerServing: Double
    let id: Int
    let title: String
    let readyInMinutes, servings: Int
    let sourceURL: String
    let image: String
    let imageType, summary: String
    let dishTypes, diets, occasions: [String]
    let instructions: String
    let spoonacularScore: Double
    let spoonacularSourceURL: String
    let extendedIngredients: [ExtendedIngredient]
}

// MARK: - ExtendedIngredient
struct ExtendedIngredient: Codable {
    let id: Int
    let aisle, image, consistency, name: String
    let nameClean, original, originalName: String
    let amount: Int
    let unit: String
}
