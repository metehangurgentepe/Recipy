//
//  SimilarRecipeCollectionViewCell.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 6.09.2024.
//

import UIKit

class SimilarRecipeCollectionViewCell: UICollectionViewCell {
    static let identifier = "SimilarRecipeCollectionCell"
    
    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .preferredFont(forTextStyle: .headline).withSize(10)
        lbl.textColor = .white
        lbl.numberOfLines = 3
        return lbl
    }()
    
    private let cookingTimeLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .preferredFont(forTextStyle: .body).withSize(10)
        lbl.textColor = .white
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let bookmarkButton: BookmarkButton = {
        let button = BookmarkButton()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(recipeImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(cookingTimeLabel)
        contentView.addSubview(bookmarkButton)
        contentView.backgroundColor = ThemeColor.bgColor

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        recipeImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(130)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        cookingTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(recipeImageView.snp.bottom).offset(3)
            make.leading.equalToSuperview()
            make.trailing.equalTo(contentView.snp.centerX)
            make.height.equalTo(10)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(cookingTimeLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        bookmarkButton.snp.makeConstraints { make in
            make.bottom.equalTo(recipeImageView.snp.bottom).inset(8)
            make.trailing.equalTo(recipeImageView.snp.trailing).inset(8)
            make.height.width.equalTo(30)
        }
    }
    
    func configure(recipe: RecipeDetailModel) {
        let imageURL = URL(string: recipe.image!)
        recipeImageView.kf.setImage(with: imageURL)
        titleLabel.text = recipe.title
        cookingTimeLabel.text = "2 hr 0 min"
        contentView.layoutIfNeeded()
    }
}
