//
//  CommunityTableViewCell.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 17.09.2024.
//

import UIKit

class CommunityCell: UITableViewCell {
    static let identifier = "CommunityCell"
    
    let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let recipeSavedButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Save recipe", for: .normal)
        button.setTitleColor(ThemeColor.pinkButtonColor, for: .normal)
        
        button.setImage(UIImage(named: "bookmark"), for: .normal)
        button.setImage(UIImage(named: "bookmark.fill"), for: .selected)
        
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        return button
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "profile")
        return imageView
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.textColor = .lightGray
        return label
    }()
    
    let recipeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = ThemeColor.pinkButtonColor
        return label
    }()
    
    let commentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    let reportButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        btn.tintColor = .white
        return btn
    }()
    
    private let heartStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 3
        
        let heartImage = UIImage(systemName: "heart")?.resizeImage(targetSize: .init(width: 14, height: 14)).withRenderingMode(.alwaysTemplate).withTintColor(ThemeColor.pinkButtonColor)
        
        let heartImageView = UIImageView(image: heartImage)
        heartImageView.tintColor = ThemeColor.pinkButtonColor
        
        let heartLabel = UILabel()
        heartLabel.font = .preferredFont(forTextStyle: .caption1).withSize(14)
        heartLabel.textColor = ThemeColor.pinkButtonColor
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
        
        let commentImage = UIImage(systemName: "bubble.left")?.resizeImage(targetSize: .init(width: 14, height: 14)).withRenderingMode(.alwaysTemplate).withTintColor(ThemeColor.pinkButtonColor)
        
        let commentImageView = UIImageView(image: commentImage)
        commentImageView.tintColor = ThemeColor.pinkButtonColor
        
        let commentLabel = UILabel()
        commentLabel.font = .preferredFont(forTextStyle: .caption1).withSize(14)
        commentLabel.textColor = ThemeColor.pinkButtonColor
        commentLabel.text = "Comments"
        
        stackView.addArrangedSubview(commentLabel)
        stackView.addArrangedSubview(commentImageView)
        
        return stackView
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSaveRecipeButton() {
        recipeSavedButton.setTitle("Recipe Saved", for: .selected)
        recipeSavedButton.setTitleColor(ThemeColor.pinkButtonColor, for: .normal)
        recipeSavedButton.backgroundColor = ThemeColor.bgColor
        recipeSavedButton.layer.cornerRadius = 20
    }
    
    
    func setup() {
        contentView.backgroundColor = ThemeColor.bgColor
        
        contentView.addSubview(recipeImageView)
        
        recipeImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(250)
        }
        
        contentView.addSubview(recipeSavedButton)
        
        recipeSavedButton.snp.makeConstraints { make in
            make.trailing.equalTo(recipeImageView.snp.trailing).inset(20)
            make.bottom.equalTo(recipeImageView.snp.bottom).inset(20)
            make.height.equalTo(40)
        }
        
        contentView.addSubview(profileImageView)
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(recipeImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(40)
        }
        
        contentView.addSubview(usernameLabel)
        
        usernameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
            make.top.equalTo(profileImageView.snp.top)
            make.height.equalTo(20)
        }
        
        contentView.addSubview(reportButton)
        
        reportButton.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
        contentView.addSubview(recipeTitleLabel)
        
        recipeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(10)
            make.leading.equalTo(usernameLabel.snp.leading)
            make.height.equalTo(40)
        }
        
        contentView.addSubview(commentLabel)
        
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(recipeTitleLabel.snp.bottom).offset(20)
            make.leading.equalTo(profileImageView.snp.leading)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        contentView.addSubview(heartStackView)
        
        heartStackView.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.leading)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        contentView.addSubview(commentStackView)
        
        commentStackView.snp.makeConstraints { make in
            make.leading.equalTo(heartStackView.snp.trailing).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
    }
    
    func configure(recipe: Recipe) {
        
    }
}
