//
//  TabBarModel.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 6.09.2024.
//

import Foundation
import UIKit

struct TabBarModel {
    let iconName: String
    let title: String
    let viewController: UIViewController
    
    var icon: UIImage? {
        return UIImage(named: iconName)
    }
    
    static func createTabBarItems() -> [TabBarModel] {
        let firstTab = TabBarModel(iconName: "", title: "Discover", viewController: HomeVC(viewModel: HomeViewModel(httpClient: .init(session: .shared))))
        let secondTab = TabBarModel(iconName: "", title: "Community", viewController: CommunityVC())
        let thirdTab = TabBarModel(iconName: "", title: "Meal Plans", viewController: MealPlansVC())
        let fourthTab = TabBarModel(iconName: "", title: "Profile", viewController: ProfileVC(collectionViewLayout: UICollectionViewFlowLayout()))
        
        
        return [firstTab, secondTab, thirdTab, fourthTab]
    }
}
