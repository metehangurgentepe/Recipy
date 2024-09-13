//
//  SavedRecipeCell.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 11.09.2024.
//

import Foundation
import UIKit

class SavedRecipeCell: UICollectionViewCell {
    static let identifier = "SavedRecipeCell"
    
    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .preferredFont(forTextStyle: .headline).withSize(16)
        lbl.textColor = .white
        lbl.numberOfLines = 3
        return lbl
    }()
    
    private let cookingTimeLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .preferredFont(forTextStyle: .body).withSize(12)
        lbl.textColor = .white
        lbl.numberOfLines = 0
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = ThemeColor.bgColor
        
        contentView.addSubview(recipeImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(cookingTimeLabel)
        contentView.backgroundColor = ThemeColor.bgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        recipeImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(130)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().inset(5)
        }
        
        cookingTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(recipeImageView.snp.bottom).offset(3)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalTo(contentView.snp.centerX)
            make.height.equalTo(10)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(cookingTimeLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().inset(5)
            make.height.equalTo(50)
        }
    }
    
    func configure(recipe: Recipe) {
        let imageURL = URL(string: recipe.image)
        recipeImageView.kf.setImage(with: imageURL)
        titleLabel.text = recipe.title
        cookingTimeLabel.text = String(20) + " minutes"
        contentView.layoutIfNeeded()
    }
}
