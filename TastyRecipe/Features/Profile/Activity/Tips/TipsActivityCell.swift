//
//  TipsActivityCell.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 12.09.2024.
//

import Foundation
import UIKit

class TipsActivityCell: UITableViewCell {
    static let identifier: String = "TipsActivityCell"
    
    var tips: [Tips] = []
    var tableView = UITableView(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        tips.append(Tips(comment: "I love this recipe so much!", count: 0, recipeTitle: "3 - Ingredient Teriyaki Chicken", date: "added 17 hours ago"))
        
        contentView.backgroundColor = ThemeColor.bgColor
        createTableView()
    }
    
    private func createTableView() {
        tableView.register(TipsCell.self, forCellReuseIdentifier: TipsCell.identifier)
        
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
    
    public func configure(tips: [Tips]) {
        self.tips = tips
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TipsActivityCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TipsCell.identifier, for: indexPath) as! TipsCell
        cell.configure(tip:tips[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
