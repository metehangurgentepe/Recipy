//
//  TableHeaderView.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 5.09.2024.
//

import UIKit

class TableHeaderView: UIView {
    let imageView = UIImageView()
    let button = BookmarkButton()
    let title = UILabel()
    let view = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(imageView)
        addSubview(view)
        addSubview(title)
        addSubview(button)
        
        imageView.image = UIImage(named: "photo")
        
        view.backgroundColor = ThemeColor.accentBlue
        
        title.textColor = .white
        title.text = "Dumpling Salad"
        title.font = .boldSystemFont(ofSize: 30)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(ScreenSize.height * 0.5)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        view.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        title.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalTo(view.snp.centerY)
            make.trailing.equalToSuperview()
            make.height.equalTo(30)
        }
        
        button.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.snp.top).offset(-20)
            make.height.width.equalTo(35)
        }
    }
}
