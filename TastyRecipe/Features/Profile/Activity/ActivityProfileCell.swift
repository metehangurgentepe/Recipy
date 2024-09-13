//
//  ActivityProfileCell.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 11.09.2024.
//

import UIKit

class ActivityProfileCell: UICollectionViewCell {
    static let identifier = "ActivityProfileCell"
    
    let activityController = ActivityController(style: .grouped)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = ThemeColor.bgColor
        
        activityController.additionalSafeAreaInsets = UIEdgeInsets(top: 10, left: 5, bottom: 0, right: 5)
        
        let activityView = activityController.view!
        addSubview(activityView)
        
        activityView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
