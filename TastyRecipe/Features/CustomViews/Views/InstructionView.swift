//
//  InstructionView.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 6.09.2024.
//

import UIKit

class InstructionView: UIView {
    let stepCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .headline).withSize(20)
        return label
    }()
    
    let stepInstructionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .body).withSize(14)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ThemeColor.bgColor
        
        layer.cornerRadius = 4
        clipsToBounds = true
        
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let fittingSize = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        self.frame.size.height = fittingSize.height
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(stepCountLabel)
        addSubview(stepInstructionLabel)
        
        stepCountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(4)
            make.height.equalTo(20)
            make.width.equalTo(30)
        }
        
        stepInstructionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(stepCountLabel.snp.trailing).offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().inset(8)
            make.height.greaterThanOrEqualTo(20)
        }
        
        stepInstructionLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        stepInstructionLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    func configure(step: Step) {
        stepCountLabel.text = "\(step.number!)"
        stepInstructionLabel.text = step.step
    }
}

