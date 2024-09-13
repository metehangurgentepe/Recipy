//
//  TipsCell.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 12.09.2024.
//

import Foundation
import UIKit

class TipsCell: UITableViewCell {
    static let identifier = "TipsCell"
    
    private let commentLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .preferredFont(forTextStyle: .body).withSize(17)
        lbl.textColor = .lightGray
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let recipeTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .preferredFont(forTextStyle: .headline).withSize(17)
        lbl.textColor = ThemeColor.pinkButtonColor
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let cookingTimeLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .preferredFont(forTextStyle: .caption1).withSize(12)
        lbl.textColor = .lightGray
        return lbl
    }()
    
    private let heartStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 3
        
        let heartImage = UIImage(systemName: "heart")?.resizeImage(targetSize: .init(width: 14, height: 14)).withRenderingMode(.alwaysOriginal)
        
        let heartImageView = UIImageView(image: heartImage)
        heartImageView.tintColor = .lightGray
        
        let heartLabel = UILabel()
        heartLabel.font = .preferredFont(forTextStyle: .caption1).withSize(14)
        heartLabel.textColor = .lightGray
        heartLabel.text = "0"
        
        stackView.addArrangedSubview(heartImageView)
        stackView.addArrangedSubview(heartLabel)
        
        return stackView
    }()
    
    private let commentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 3
        
        let commentImage = UIImage(systemName: "bubble.left")?.resizeImage(targetSize: .init(width: 14, height: 14)).withRenderingMode(.alwaysOriginal)
        
        let commentImageView = UIImageView(image: commentImage)
        commentImageView.tintColor = .lightGray
        
        let commentLabel = UILabel()
        commentLabel.font = .preferredFont(forTextStyle: .caption1).withSize(14)
        commentLabel.textColor = .lightGray
        commentLabel.text = "Comments"
        
        stackView.addArrangedSubview(commentImageView)
        stackView.addArrangedSubview(commentLabel)
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(commentLabel)
        contentView.addSubview(recipeTitleLabel)
        contentView.addSubview(cookingTimeLabel)
        contentView.addSubview(heartStackView)
        contentView.addSubview(commentStackView)
        
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = ThemeColor.lightBackgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        commentLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.height.equalTo(20)
        }
        
        heartStackView.snp.makeConstraints { make in
            make.top.equalTo(commentLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(5)
            make.width.equalTo(25)
            make.height.equalTo(15)
        }
        
        commentStackView.snp.makeConstraints { make in
            make.top.equalTo(commentLabel.snp.bottom).offset(4)
            make.leading.equalTo(heartStackView.snp.trailing).offset(8)
            make.height.equalTo(15)
        }
        
        recipeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(heartStackView.snp.bottom).offset(6)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.height.equalTo(25)
        }
        
        cookingTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(recipeTitleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.height.equalTo(10)
        }
        
    }
    
    func configure(tip: Tips) {
        commentLabel.text = tip.comment
        cookingTimeLabel.text = tip.date
        recipeTitleLabel.text = tip.recipeTitle
        contentView.layoutIfNeeded()
    }
}
