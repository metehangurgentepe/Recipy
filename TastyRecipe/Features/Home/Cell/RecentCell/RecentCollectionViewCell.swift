//
//  RecentCollectionViewCell.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 9.09.2024.
//

import UIKit

class RecentCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecentCollectionCell"
    var recipe: Recipe?
    
    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .preferredFont(forTextStyle: .headline).withSize(14)
        lbl.textColor = .white
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.baselineAdjustment = .alignBaselines
        lbl.adjustsFontSizeToFitWidth = true
        lbl.lineBreakMode = .byTruncatingTail
        lbl.sizeToFit()
        return lbl
    }()
    
    private let cookingTimeLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .preferredFont(forTextStyle: .body).withSize(12)
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
            make.height.lessThanOrEqualTo(90)
            make.width.lessThanOrEqualTo(contentView.snp.width)
        }
        
        bookmarkButton.snp.makeConstraints { make in
            make.bottom.equalTo(recipeImageView.snp.bottom).inset(8)
            make.trailing.equalTo(recipeImageView.snp.trailing).inset(8)
            make.height.width.equalTo(30)
        }
    }
    
    private func checkIsBookmarked() {
        if let bookmarkedRecipes = UserDefaultsManager.shared.getCodable(forKey: "recipe", type: [Recipe].self) {
            bookmarkedRecipes.map { recipe in
                if recipe.id == self.recipe?.id{
                    bookmarkButton.isSelected = true
                } else {
                    bookmarkButton.isSelected = false
                }
            }
        }
    }
    
    func configure(recipe: Recipe) {
        self.recipe = recipe
        let imageURL = URL(string: recipe.image)
        recipeImageView.kf.setImage(with: imageURL)
        titleLabel.text = recipe.title
        cookingTimeLabel.text = String(20) + " minutes"
        checkIsBookmarked()
        bookmarkButton.addTarget(self, action: #selector(bookmarkedButtonTapped), for: .touchUpInside)
        contentView.layoutIfNeeded()
    }
    
    @objc func bookmarkedButtonTapped() {
        guard let recipe else { return }
        
        if var arr = UserDefaultsManager.shared.getCodable(forKey: "recipe", type: [Recipe].self){
            for i in 0..<arr.count {
                guard arr.count > 0 else { break }
                
                if arr[i].id == self.recipe?.id {
                    arr.remove(at: i)
                    UserDefaultsManager.shared.saveCodable(value: arr, forKey: "recipe")
                    bookmarkButton.isSelected = false
                    return
                }
            }
            
            arr.append(recipe)
            UserDefaultsManager.shared.saveCodable(value: arr, forKey: "recipe")
            bookmarkButton.isSelected = true
        }
    }
}
