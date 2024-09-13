//
//  ActivityController.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 11.09.2024.
//

import UIKit

class ActivityController: UITableViewController {
    var recipes: [Recipe] = []
    
    enum Section: CaseIterable {
        case myRatings
        case myTips
        case recentylyViewed
        
        var description: String {
            switch self {
            case .myRatings: return "My Ratings"
            case .myTips: return "My Tips"
            case .recentylyViewed: return "Recently Viewed"
            }
        }
    }
    
    let viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(RatingActivityCell.self, forCellReuseIdentifier: RatingActivityCell.identifier)
        self.tableView.register(TipsActivityCell.self, forCellReuseIdentifier: TipsActivityCell.identifier)
        self.tableView.register(RecentlyViewedActivityCell.self, forCellReuseIdentifier: RecentlyViewedActivityCell.identifier)

        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        viewModel.delegate = self
        viewModel.fetchSavedRecipes()
        
        self.tableView.backgroundColor = ThemeColor.bgColor
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch Section.allCases[section] {
        case .myRatings:
           return Header(title: Section.myRatings.description)
        case .myTips:
           return Header(title: Section.myTips.description)
        case .recentylyViewed:
            return Header(title: Section.recentylyViewed.description)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: RatingActivityCell.identifier, for: indexPath) as! RatingActivityCell
            cell.configure(recipes: self.recipes)
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TipsActivityCell.identifier, for: indexPath) as! TipsActivityCell
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: RecentlyViewedActivityCell.identifier, for: indexPath) as! RecentlyViewedActivityCell
            cell.configure(recipes: self.recipes)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 300
        case 2:
            return 200
        default:
            return 150
        }
    }
}

extension ActivityController: ProfileViewModelProtocol {
    func fetchSavedRecipes(recipes: [Recipe]) {
        self.recipes = recipes
        tableView.reloadData()
    }
    
    func showError(_ error: any Error) {
        let ac = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}
