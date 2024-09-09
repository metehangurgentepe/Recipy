//
//  IngredientTableViewCell.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 6.09.2024.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {
    static let identifier = "IngredientCell"
    
    let ingredientNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .body).withSize(12)
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .headline).withSize(12)
        label.numberOfLines = 1
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createCell()
        contentView.backgroundColor = ThemeColor.bgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(ingredient: ExtendedIngredient) {
        ingredientNameLabel.text = ingredient.originalName!
        amountLabel.text = "\(ingredient.amount!) \(ingredient.unit!)"
    }
    
    private func createCell() {
        contentView.addSubview(ingredientNameLabel)
        contentView.addSubview(amountLabel)
        
        ingredientNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.trailing.lessThanOrEqualTo(amountLabel.snp.leading).offset(-10)
        }
        
        amountLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.greaterThanOrEqualTo(50)
            make.width.lessThanOrEqualToSuperview().multipliedBy(0.3)
        }
    }
    
}
