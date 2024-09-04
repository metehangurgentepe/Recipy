//
//  RecipeCell.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 3.09.2024.
//

import UIKit
import Kingfisher

class RecipeCell: UICollectionViewCell {
    static let identifier = "RecipeCell"
    var recipe: Recipe?
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline).withSize(18)
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        
        addSubview(imageView)
        addSubview(blurView)
        addSubview(nameLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading).offset(30)
            make.trailing.equalTo(contentView.snp.trailing).offset(-30)
            make.bottom.equalTo(contentView.snp.bottom)
            make.width.equalTo(ScreenSize.width - 60)
        }
        
        blurView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(-60)
            make.leading.equalTo(imageView.snp.leading)
            make.trailing.equalTo(imageView.snp.trailing)
            make.bottom.equalTo(imageView.snp.bottom)
            make.width.equalTo(ScreenSize.width)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(blurView.snp.top)
            make.bottom.equalTo(blurView.snp.bottom)
            make.leading.equalTo(blurView.snp.leading).offset(15)
            make.trailing.equalTo(blurView.snp.trailing).offset(-15)
            make.width.equalTo(ScreenSize.width - 30)
        }
        
        let maskLayer = CAShapeLayer()
        
        blurView.layoutIfNeeded()
        
        let path = UIBezierPath(roundedRect: blurView.bounds,
                                byRoundingCorners: [.bottomLeft, .bottomRight],
                                cornerRadii: CGSize(width: 10, height: 10))
        maskLayer.path = path.cgPath
        blurView.layer.mask = maskLayer
    }
    
    func configure(recipe: Recipe) {
        self.recipe = recipe
        
        let url = URL(string: recipe.image)
        imageView.kf.setImage(with: url)
        
        nameLabel.text = recipe.title
        
        setupSubviews()
    }
}
