//
//  MainCell.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 10.09.2024.
//

import Foundation
import UIKit

class MainCell: UICollectionViewCell {
    
    static let identifier = "MainCell"
    let savedRecipesController = SavedRecipeController(collectionViewLayout: UICollectionViewFlowLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = ThemeColor.bgColor
        
        savedRecipesController.additionalSafeAreaInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
        let savedRecipesView = savedRecipesController.view!
        addSubview(savedRecipesView)
        
        savedRecipesView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
