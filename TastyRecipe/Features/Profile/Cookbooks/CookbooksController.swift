//
//  CookbooksController.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 11.09.2024.
//

import UIKit

class CookbooksController: UITableViewController {
    var cookbooks: [Cookbook] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(CookbookCell.self, forCellReuseIdentifier: CookbookCell.identifier)
        
        self.tableView.backgroundColor = ThemeColor.bgColor
        tableView.separatorStyle = .none

        cookbooks.append(Cookbook(title: "Appetizers", recipeCount: 0))
        cookbooks.append(Cookbook(title: "Bakery Goods", recipeCount: 0))
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cookbooks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CookbookCell.identifier, for: indexPath) as! CookbookCell
        let cookbook = cookbooks[indexPath.row]
        cell.configure(with: cookbook)
        return cell
    }

}
