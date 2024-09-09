//
//  TimeView.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 6.09.2024.
//

import UIKit

class TimeView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .body).withSize(14)
        return label
    }()
    
    convenience init(title: String, time: String) {
        self.init(frame: .zero)
        titleLabel.text = title
        timeLabel.text = time
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(titleLabel)
        addSubview(timeLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.width.equalToSuperview()
        }
    }
}
