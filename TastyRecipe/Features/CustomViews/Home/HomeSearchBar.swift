//
//  HomeSearchBar.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 5.09.2024.
//

import UIKit

protocol HomeSearchBarDelegate: AnyObject{
    func navigate()
    func didTapReturn(query: String?)
}

class HomeSearchBar: UISearchBar, UITextFieldDelegate {
    
    let padding = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 5)
    let stackView = UIStackView()
    let iconImageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
    let label = UILabel()
    weak var searchBarDelegate: HomeSearchBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        searchTextField.textColor = .systemGray
        searchTextField.layer.cornerRadius = 20
        searchTextField.layer.masksToBounds = true
        searchTextField.tintColor = .lightGray
        searchTextField.layer.borderColor = UIColor.lightGray.cgColor
        searchTextField.layer.borderWidth = 1.0
        searchTextField.sizeToFit()
        
        iconImageView.tintColor = .lightGray
        iconImageView.frame.size = CGSize(width: 20, height: 20)
        
        label.text = "Search Tasty"
        label.textColor = .lightGray
        
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(label)
        
        let screenWidth = UIScreen.main.bounds.width
        let spacing = (screenWidth - 200 - 40) / 2
        
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
    
    private func configureStackView() -> UIStackView {
        let stack = UIStackView()
        
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        
        imageView.tintColor = .lightGray
        imageView.frame.size = CGSize(width: 20, height: 20)
        imageView.contentMode = .scaleAspectFit
        
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
        
        label.text = "Search Tasty"
        label.textColor = .lightGray
        
        stack.addArrangedSubview(imageView)
        stack.addArrangedSubview(label)
        
        let screenWidth = UIScreen.main.bounds.width
        let spacing = (screenWidth - 200 - 40) / 2
        
        stack.axis = .horizontal
        stack.spacing = spacing
        stack.alignment = .leading
        stack.distribution = .fill
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeStackView))
        stack.addGestureRecognizer(tapGesture)
        stack.isUserInteractionEnabled = true
        
        return stack
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        searchBarDelegate?.didTapReturn(query: textField.text)
        searchTextField.leftView = iconImageView
        return true
    }
    
    @objc func removeStackView() {
        searchTextField.leftView = nil
        self.textFieldDidBeginEditing(searchTextField)
        searchBarDelegate?.navigate()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchTextField.leftView = iconImageView
        searchTextField.becomeFirstResponder()
        searchBarDelegate?.navigate()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchTextField.leftView = configureStackView()
    }
}
