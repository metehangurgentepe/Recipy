//
//  BookmarkButton.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 4.09.2024.
//

import UIKit

class BookmarkButton: UIButton {
    var image = UIImage(named: "bookmark")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet{
            let fillImage = UIImage(named: "bookmark.fill")
            isSelected ? setImage(fillImage, for: .selected) : setImage(image, for: .normal)
        }
    }
    
    private func configure() {
        layer.cornerRadius = frame.size.width / 2
        layer.backgroundColor = UIColor.black.cgColor
        clipsToBounds = true
        
        setImage(image, for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.size.width / 2
    }
}
