//
//  CapsuleLabel.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 8.09.2024.
//

import Foundation
import UIKit

class CapsuleLabel: UILabel {
    
    private var imageView: UIImageView?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let cornerRadius: CGFloat = bounds.height / 2
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
    
    convenience init(text: String, image: UIImage) {
        self.init(frame: .zero)
        
        self.text = text
        
        let imageView = UIImageView(image: image)
        self.imageView = imageView
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(5)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(15)
        }
       
        self.snp.makeConstraints { make in
            make.leading.equalTo(snp.leading).offset(2)
            make.height.equalTo(20)
            make.width.greaterThanOrEqualTo(100)
        }
        
        self.setPadding(left: 10, right: 30)
    }
    
    private func setPadding(left: CGFloat, right: CGFloat) {
        self.drawText(in: CGRect(
            x: self.bounds.origin.x + left,
            y: self.bounds.origin.y,
            width: self.bounds.width - right - left,
            height: self.bounds.height
        ))
    }
    
    override var intrinsicContentSize: CGSize {
        let originalSize = super.intrinsicContentSize
        return CGSize(width: originalSize.width + 30, height: originalSize.height)
    }
}
