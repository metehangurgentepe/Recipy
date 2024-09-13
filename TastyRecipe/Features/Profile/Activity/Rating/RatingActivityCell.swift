//
//  RatingActivityCell.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 11.09.2024.
//

import Foundation
import UIKit


class RatingActivityCell: UITableViewCell {
    static let identifier: String = "RatingActivityCell"
    
    var recipesArr: [Recipe] = []
    var tableView = UITableView(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = ThemeColor.bgColor
        
        createTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createTableView() {
        tableView.register(RatingCell.self, forCellReuseIdentifier: RatingCell.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = ThemeColor.bgColor
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 10))
        headerView.backgroundColor = .clear
        tableView.tableHeaderView = headerView
        
        contentView.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
        }
    }
    
    public func configure(recipes: [Recipe]) {
        self.recipesArr = recipes
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
}

extension RatingActivityCell: UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RatingCell.identifier, for: indexPath) as! RatingCell
        cell.configure(recipe: recipesArr[indexPath.row])
        return cell
    }
}
