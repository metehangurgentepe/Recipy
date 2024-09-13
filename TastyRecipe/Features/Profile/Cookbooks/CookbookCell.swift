
//
//  CookbookCell.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 11.09.2024.
//

import UIKit

class CookbookCell: UITableViewCell {
    
    static let identifier = "CookbookCell"
    
    private let cookbookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "placeholder")
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let cookbookName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .label
        return label
    }()
    
    private let recentCount: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .secondaryLabel
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = ThemeColor.bgColor
        contentView.addSubview(cookbookImageView)
        contentView.addSubview(cookbookName)
        contentView.addSubview(recentCount)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        cookbookImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(4)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-4)
            make.height.equalTo(60)
            make.width.equalTo(100)
        }
        
        cookbookName.snp.makeConstraints { make in
            make.leading.equalTo(cookbookImageView.snp.trailing).offset(12)
            make.top.equalTo(cookbookImageView.snp.top)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        recentCount.snp.makeConstraints { make in
            make.leading.equalTo(cookbookImageView.snp.trailing).offset(12)
            make.top.equalTo(cookbookName.snp.bottom).offset(4)
            make.trailing.equalToSuperview().offset(-12)
        }
    }
    
    func configure(with cookbook: Cookbook) {
        cookbookName.text = cookbook.title
        recentCount.text = "\(cookbook.recipeCount) recipes"
    }
}
