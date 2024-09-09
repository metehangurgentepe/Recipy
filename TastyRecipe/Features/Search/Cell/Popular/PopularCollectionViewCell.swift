//
//  PopularCollectionViewCell.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 6.09.2024.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
    static let identifier = "PopularCollectionCell"
    let icon = UIImageView()
    
    let label: UILabel = {
        let lbl = UILabel()
        lbl.font = .preferredFont(forTextStyle: .headline).withSize(14)
        lbl.textColor = .white
        lbl.numberOfLines = 2
        return lbl
    }()
    
    override func layoutSubviews() {
        contentView.backgroundColor = ThemeColor.lightBackgroundColor
        contentView.layer.cornerRadius = 4
        
        contentView.addSubview(icon)
        contentView.addSubview(label)
        
        icon.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(25)
        }
        
        label.snp.makeConstraints { make in
            make.leading.equalTo(icon.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-5)
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(item: PopularModel) {
        icon.image = item.icon
        label.text = item.title
    }
}
