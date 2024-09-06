//
//  HomeSearchBar.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 5.09.2024.
//

import UIKit

import UIKit

class HomeSearchBar: UISearchBar, UITextFieldDelegate {
    
    let padding = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 5)
    let stackView = UIStackView()
    let iconImageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        // Configure search text field
        searchTextField.textColor = .systemGray
        searchTextField.layer.cornerRadius = 20
        searchTextField.layer.masksToBounds = true
        searchTextField.tintColor = .lightGray
        searchTextField.layer.borderColor = UIColor.lightGray.cgColor
        searchTextField.layer.borderWidth = 1.0
        searchTextField.sizeToFit()
        
        // Configure placeholder drawing
        searchTextField.drawPlaceholder(in: bounds.inset(by: padding))
        
        // Configure icon image view
        iconImageView.tintColor = .lightGray
        iconImageView.frame.size = CGSize(width: 20, height: 20)
        
        // Configure label
        label.text = "Search Tasty"
        label.textColor = .lightGray
        
        // Configure stack view
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(label)
        
        let screenWidth = UIScreen.main.bounds.width
        let spacing = max((screenWidth - 200 - 20) / 2, 8)
        
        stackView.axis = .horizontal
        stackView.spacing = spacing
        stackView.alignment = .leading
        stackView.distribution = .fill
        
        searchTextField.leftView = stackView
        searchTextField.leftViewMode = .always
        
        searchTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeStackView))
        stackView.addGestureRecognizer(tapGesture)
    }
    
    @objc func removeStackView() {
        searchTextField.leftView = iconImageView
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchTextField.leftView = iconImageView
    }
    
    // UITextFieldDelegate method to handle when the search bar loses focus
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchTextField.leftView = stackView
    }
}
