//
//  RatingCell.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 11.09.2024.
//

import UIKit

class RatingCell: UITableViewCell {
    static let identifier = "RatingCell"
    
    private let okeyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "hand.thumbsup.circle")
        imageView.tintColor = .green
        return imageView
    }()
    
    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = ThemeColor.bgColor
        
        contentView.addSubview(recipeImageView)
        contentView.addSubview(okeyImageView)
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
            make.height.width.equalTo(70)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        okeyImageView.snp.makeConstraints { make in
            make.bottom.equalTo(recipeImageView.snp.centerY)
            make.trailing.equalTo(recipeImageView.snp.centerX)
            make.width.height.equalTo(15)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(recipeImageView.snp.top)
            make.leading.equalTo(recipeImageView.snp.trailing).offset(3)
            make.trailing.equalToSuperview().inset(5)
            make.height.equalTo(20)
        }
        
        cookingTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(recipeImageView.snp.trailing).offset(3)
            make.trailing.equalToSuperview().inset(5)
            make.height.equalTo(10)
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
