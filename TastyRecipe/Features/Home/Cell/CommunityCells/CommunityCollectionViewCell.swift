//
//  CommunityCollectionViewCell.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 5.09.2024.
//

import UIKit

class CommunityCollectionViewCell: UICollectionViewCell {
    static let identifier = "CommunityCollectionCell"
    
    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 2
        imageView.layer.masksToBounds = true
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .preferredFont(forTextStyle: .headline).withSize(10)
        lbl.textColor = .white
        lbl.numberOfLines = 3
        return lbl
    }()
    
    private let backgroundBottomView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 2
        view.backgroundColor = ThemeColor.lightBackgroundColor
        return view
    }()
    
    private let likedCountView = UIStackView()
    
    private let profileImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = ThemeColor.bgColor.withAlphaComponent(0.5)
        contentView.layer.cornerRadius = 4
        contentView.layer.backgroundColor = ThemeColor.bgColor.withAlphaComponent(0.5).cgColor
        
        contentView.addSubview(recipeImageView)
        contentView.addSubview(backgroundBottomView)
        contentView.addSubview(profileImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(likedCountView)
        
        profileImageView.layer.cornerRadius = 10
        profileImageView.clipsToBounds = true
        
        configureLikedCountView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLikedCountView() {
        let image = UIImageView(image: UIImage(named: "heart"))
        
        image.contentMode = .scaleAspectFit
        image.snp.makeConstraints { make in
            make.width.height.equalTo(15)
        }
        
        let label = UILabel()
        label.text = "839"
        label.textColor = .white
        label.font = .systemFont(ofSize: 9)
        
        likedCountView.alignment = .center
        likedCountView.distribution = .equalCentering
        likedCountView.axis = .horizontal
        likedCountView.spacing = 2
        
        likedCountView.addArrangedSubview(image)
        likedCountView.addArrangedSubview(label)
    }
    
    override func layoutSubviews() {
        recipeImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(230)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        backgroundBottomView.snp.makeConstraints { make in
            make.top.equalTo(recipeImageView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(recipeImageView.snp.bottom).offset(4)
            make.leading.equalTo(recipeImageView.snp.leading).offset(2)
            make.height.width.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(recipeImageView.snp.bottom).offset(4)
            make.leading.equalTo(profileImageView.snp.trailing).offset(4)
            make.trailing.equalToSuperview().inset(2)
            make.height.equalTo(25)
        }
        
        likedCountView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    func configure(recipe: Recipe) {
        let imageURL = URL(string: recipe.image)
        let profileImageURL = URL(string: "https://img.freepik.com/free-photo/portrait-man-laughing_23-2148859448.jpg?t=st=1725560349~exp=1725563949~hmac=4c2dd3a8c441cc7381221b581eecfec3437c4f911837b943989c23e76516878e&w=1380")
        
        recipeImageView.kf.setImage(with: imageURL)
        profileImageView.kf.setImage(with: profileImageURL)
        
        titleLabel.text = recipe.title
        contentView.layoutIfNeeded()
    }
}

