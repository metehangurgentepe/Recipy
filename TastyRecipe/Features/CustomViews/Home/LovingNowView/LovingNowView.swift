//
//  LovingNowView.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 4.09.2024.
//

import UIKit

class LovingNowView: UIView {
    
    var imageView = UIImageView()
    var titleBackgroundView = UIView()
    var nameLabel = UILabel()
    var cookingTimeLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        
        titleBackgroundView.backgroundColor = .systemBlue
        
        addSubview(imageView)
        addSubview(titleBackgroundView)
        addSubview(nameLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview()
            make.width.equalTo(ScreenSize.width - 20)
            make.height.equalTo(ScreenSize.height / 0.65)
        }
        
        titleBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(-60)
            make.leading.equalTo(imageView.snp.leading)
            make.trailing.equalTo(imageView.snp.trailing)
            make.bottom.equalTo(imageView.snp.bottom)
            make.height.equalTo(60)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(titleBackgroundView.snp.top)
            make.bottom.equalTo(titleBackgroundView.snp.bottom)
            make.leading.equalTo(titleBackgroundView.snp.leading).offset(15)
            make.trailing.equalTo(titleBackgroundView.snp.trailing).offset(-15)
        }
        
        let maskLayer = CAShapeLayer()
        
        titleBackgroundView.layoutIfNeeded()
        
        let path = UIBezierPath(roundedRect: titleBackgroundView.bounds,
                                byRoundingCorners: [.bottomLeft, .bottomRight],
                                cornerRadii: CGSize(width: 10, height: 10))
        maskLayer.path = path.cgPath
        titleBackgroundView.layer.mask = maskLayer
    }
    
    private func configureImageView() {
        
    }
    
    private func configureTitleBackgroundView() {
        
    }
    
    private func configureTitleLabel() {
        
    }
    
    private func configureCookingTimeLabel() {
        
    }
    

}
