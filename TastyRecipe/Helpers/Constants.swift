//
//  Constants.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 3.09.2024.
//

import Foundation
import UIKit


enum Constants {
    static let baseURL = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
    static let authApiKey = ["x-rapidapi-key":"12fc49a2acmsh23391a8540304a3p1314eejsn2a0529976ba5"]
    static let tastyURL = "https://tasty.p.rapidapi.com"
}

enum Images {
    static let metflixLogo = UIImage(named: "metflixIcon")
    static let infoButton = UIImage(named: "info.circle")
    static let playButton = UIImage(named: "playButton")
    static let defaultPhoto = UIImage(named: "fight_club")
    
    static let pot = UIImage(named: "pot")
    static let selectedPot = UIImage(named: "selectedPot")
    static let calendar = UIImage(named: "calendar")
    static let selectedCalendar = UIImage(named: "selectedCalendar")
    static let search = UIImage(named: "search")
    static let selectedSearch = UIImage(named: "selectedSearch")
    static let person = UIImage(named: "person")
    static let selectedPerson = UIImage(named: "selectedPerson")
}

enum SFSymbols {
    static let person =  UIImage(systemName: "person")
    static let playRectangle = UIImage(systemName:"play.rectangle")
    static let home = UIImage(systemName:"house")
    static let selectedHome = UIImage(systemName:"house.fill")
    static let search = UIImage(systemName: "magnifyingglass")
    static let selectedSearch = UIImage(systemName: "magnifyingglass.circle.fill")
    static let favorites = UIImage(systemName:"heart")
    static let selectedFavorites = UIImage(systemName:"heart.fill")
    static let followers = UIImage(systemName:"heart")
    static let following = UIImage(systemName:"person.2")
    static let filter = UIImage(systemName: "line.3.horizontal.decrease.circle.fill")
    static let question = UIImage(systemName: "questionmark")
    static let starFill = UIImage(systemName: "star.fill")
    static let star = UIImage(systemName: "star.fill")
    static let halfStar = UIImage(systemName: "star.lefthalf.fill")
    static let lane = UIImage(systemName: "lane")
    static let discover = UIImage(systemName: "magnifyingglass")
    static let selectedDiscover = UIImage(systemName: "magnifyingglass.circle.fill")
    
}

enum QueryList {
    static let difficultyList: [String] = [
        "Under 1 Hour",
        "Under 45 Minutes",
        "Under 15 Minutes",
        "Under 30 Minutes",
        "Easy",
        "5 Ingredients or Less"
     ]
    
    static let dietsList: [String] = [
        "Alcohol-Free",
        "Kosher",
        "Halal",
        "Keto",
        "Pescatarian",
        "Vegetarian",
        "Vegan",
        "Gluten-Free",
        "Dairy-Free"
     ]
    
    static let mealList: [String] = [
        "Snacks",
        "Sides",
        "Lunch",
        "Drinks",
        "Dinner",
        "Desserts",
        "Brunch",
        "Breakfast",
        "Appetizers",
    ]
    
    static let cookingList: [String] = [
        "Budget",
        "Pan Fry",
        "One-Pot or Pan",
        "No Bake Desserts",
        "Meal Prep",
        "Big Batch",
        "Steam",
        "Grill",
        "Deep-Fry",
        "Kid-Friendly",
        "Comfort Food",
    ]
    
    static let cuisine: [String] = [
        "North American",
        "Jewish",
        "European",
        "Indigenous",
        "Caribbean",
        "African",
        "Fusion",
        "Middle Eastern",
        "Central & South American",
        "Asian"
        
    ]
}

