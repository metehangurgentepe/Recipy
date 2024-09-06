//
//  BookmarkButton.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 4.09.2024.
//

import UIKit

class BookmarkButton: UIButton {
    var bookmarked: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        let image = UIImage(named: "bookmark")
        
        layer.cornerRadius = frame.size.width / 2
        layer.backgroundColor = UIColor.black.cgColor
        clipsToBounds = true
        
        setImage(image, for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Ensure the button layout is updated when needed
        layer.cornerRadius = frame.size.width / 2
    }
    
}
