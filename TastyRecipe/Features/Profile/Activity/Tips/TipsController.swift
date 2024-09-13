//
//  TipsController.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 12.09.2024.
//

import Foundation
import UIKit

class TipsController: UITableViewController {
    var tips = [Tips]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TipsCell.self, forCellReuseIdentifier: TipsCell.identifier)
        tableView.backgroundColor = ThemeColor.bgColor
        tableView.separatorStyle = .none
        
        tips.append(Tips(comment: "I love this recipe so much!", count: 0, recipeTitle: "3 - Ingredient Teriyaki Chicken", date: "added 17 hours ago"))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tips.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TipsCell.identifier, for: indexPath) as! TipsCell
        cell.configure(tip: tips[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
