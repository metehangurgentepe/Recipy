//
//  PopularModel.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 6.09.2024.
//

import Foundation
import UIKit

struct PopularModel {
    let title: String
    let icon: UIImage
    
    static let list: [PopularModel] = [
        PopularModel(title: "Easy Dinner", icon: UIImage(named: "dinner")!),
        PopularModel(title: "5 Ingredients or Less", icon: UIImage(named: "hot-soup")!),
        PopularModel(title: "Under 30 Minutes", icon: UIImage(named: "clock")!),
        PopularModel(title: "Chicken", icon: UIImage(named: "chicken-leg")!),
        PopularModel(title: "Breakfast", icon: UIImage(named: "pancakes")!),
        PopularModel(title: "Desserts", icon: UIImage(named: "cookie")!),
    ]
}
