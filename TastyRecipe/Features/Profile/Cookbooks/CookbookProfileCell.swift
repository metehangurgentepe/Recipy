//
//  CookbookProfileCell.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 11.09.2024.
//

import UIKit

class CookbookProfileCell: UICollectionViewCell {
    static let identifier = "CookbookProfileCell"
    
    let cookbooksController = CookbooksController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = ThemeColor.bgColor
        
        cookbooksController.additionalSafeAreaInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
        let cookbooksView = cookbooksController.view!
        addSubview(cookbooksView)
        
        cookbooksView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
