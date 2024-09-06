//
//  TabBarViewController.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 3.09.2024.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers = TabBarModel.createTabBarItems().map{ $0.viewController }
        setupTabs()
        self.tabBar.tintColor = .white
        self.tabBar.isTranslucent = true
        UITabBar.appearance().barTintColor = .clear
    }
    
    private func setupTabs() {
        let firstVC = TabBarModel.createTabBarItems()[0]
        let secondVC = TabBarModel.createTabBarItems()[1]
        let thirdVC = TabBarModel.createTabBarItems()[2]
        let fourthVC = TabBarModel.createTabBarItems()[3]
        
        let home = self.createNav(
            with: firstVC.title,
            and: Images.search,
            selectedImage: Images.selectedSearch,
            vc: firstVC.viewController)
        
        let search = self.createNav(
            with: secondVC.title,
            and:Images.pot,
            selectedImage: Images.selectedPot,
            vc: secondVC.viewController)
        
        let saved = self.createNav(
            with: thirdVC.title,
            and: Images.selectedCalendar,
            selectedImage: Images.selectedCalendar,
            vc: thirdVC.viewController)
        
        let profile = self.createNav(
            with: fourthVC.title,
            and: Images.person,
            selectedImage: Images.selectedPerson,
            vc: fourthVC.viewController)
        
        self.setViewControllers([home,search,saved,profile], animated: true)
    }
    
    private func createNav(with title: String, and image: UIImage?, selectedImage: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image?.resizeImage(targetSize: CGSize(width: 30, height: 30))
        nav.tabBarItem.selectedImage = selectedImage?.resizeImage(targetSize: CGSize(width: 30, height: 30))
        return nav
    }
    
}
