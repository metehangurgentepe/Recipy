//
//  TastyMealPlansCollectionViewCell.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 17.09.2024.
//

import UIKit

class TastyMealPlansCollectionViewCell: UICollectionViewCell {
    static let identifier = "TastyMealPlansCollectionViewCell"
    
    private let backgroundView1: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        view.layer.cornerRadius = 4
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2.0
        view.layer.masksToBounds = true
        return view
    }()
    
    private let backgroundView2: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 4
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2.0
        view.layer.masksToBounds = true
        return view
    }()
    
    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 2.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let recipeCountView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        return view
    }()
    
    let label: UILabel = {
        let lbl = UILabel()
        lbl.font = .preferredFont(forTextStyle: .headline).withSize(8)
        lbl.textColor = .black
        lbl.text = "4 recipes"
        return lbl
    }()
    
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .preferredFont(forTextStyle: .headline).withSize(12)
        lbl.textColor = .white
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.baselineAdjustment = .alignBaselines
        lbl.lineBreakMode = .byTruncatingTail
        lbl.sizeToFit()
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        contentView.addSubview(backgroundView1)
        contentView.addSubview(backgroundView2)
        contentView.addSubview(recipeImageView)
        
        contentView.addSubview(recipeCountView)
        contentView.addSubview(label)
        contentView.addSubview(titleLabel)
        
        contentView.backgroundColor = ThemeColor.bgColor
        
        recipeImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(contentView.snp.width).multipliedBy(0.8)
            make.height.equalTo(recipeImageView.snp.width)
        }
        
        backgroundView1.snp.makeConstraints { make in
            make.centerX.equalTo(recipeImageView.snp.leading)
            make.centerY.equalTo(recipeImageView.snp.bottom)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.8)
            make.height.equalTo(recipeImageView.snp.width)
        }
        
        backgroundView2.snp.makeConstraints { make in
            make.centerX.equalTo(recipeImageView.snp.trailing)
            make.centerY.equalTo(recipeImageView.snp.bottom)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.8)
            make.height.equalTo(recipeImageView.snp.width)
        }
        
        recipeCountView.snp.makeConstraints { make in
            make.bottom.equalTo(recipeImageView.snp.bottom).inset(3)
            make.leading.equalTo(recipeImageView.snp.centerX)
            make.trailing.equalTo(recipeImageView.snp.trailing)
            make.height.equalTo(20)
        }
        
        label.snp.makeConstraints { make in
            make.centerX.equalTo(recipeCountView.snp.centerX)
            make.centerY.equalTo(recipeCountView.snp.centerY)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(recipeImageView.snp.bottom).offset(4)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.lessThanOrEqualTo(50)
            make.width.lessThanOrEqualTo(contentView.snp.width)
        }
    }
    
    func configure(recipe: Recipe) {
        let imageURL = URL(string: recipe.image)
        recipeImageView.kf.setImage(with: imageURL)
        titleLabel.text = recipe.title
        label.text = "4 recipes"
        setupRotations()
        contentView.layoutIfNeeded()
    }
    
    private func setupRotations() {
        backgroundView1.rotateAroundBottomLeft(angle: -.pi/30)
        backgroundView2.rotateAroundBottomRight(angle: .pi/30)
    }
}
