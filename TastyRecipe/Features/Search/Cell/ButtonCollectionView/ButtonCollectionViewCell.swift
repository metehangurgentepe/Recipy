//
//  ButtonCollectionViewCell.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 7.09.2024.
//

import UIKit


class ButtonCollectionViewCell: UICollectionViewCell {
    static let identifier = "ButtonCollectionCell"
    
    private let label = CapsuleLabel()
    
    var title: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override var isSelected: Bool {
        didSet {
            configure(title: title!)
        }
    }
    
    
    func setupUI() {
        addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.leading.equalTo(snp.leading)
            make.trailing.equalTo(snp.trailing)
            make.bottom.equalTo(snp.bottom)
        }
    }
    
    
    func configure(title: String) {
        self.title = title
        label.font = .preferredFont(forTextStyle: .headline).withSize(12)
        label.text = title
        label.textColor = .white
        label.backgroundColor = ThemeColor.buttonBgColor
        label.textAlignment = .center
    }
}
