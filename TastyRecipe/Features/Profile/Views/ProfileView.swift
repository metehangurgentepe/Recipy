//
//  ProfileView.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 11.09.2024.
//

import Foundation
import UIKit


class ProfileView: UIView {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Metehan Gürgentepe"
        label.font = .preferredFont(forTextStyle: .largeTitle).withSize(30)
        label.textColor = .label
        return label
    }()
    
    var stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ThemeColor.bgColor
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabel() {
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(stackView)
        
        profileImageView.layer.cornerRadius = 100 / 2
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.width.equalTo(100)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        let ratingView = RatingView()
        ratingView.setup(number: 0, title: "ratings")
        
        let tipView = RatingView()
        tipView.setup(number: 0, title: "tips")
        
        let photosView = RatingView()
        photosView.setup(number: 0, title: "photos")
        
        stackView = UIStackView(arrangedSubviews: [ratingView, tipView, photosView])
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.spacing = 10
        stackView.backgroundColor = ThemeColor.bgColor
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ScreenSize.width / 6)
            make.trailing.equalToSuperview().offset(-(ScreenSize.width / 6))
            make.top.equalTo(nameLabel.snp.bottom).offset(16)
            make.height.equalTo(50)
        }
    }
}
