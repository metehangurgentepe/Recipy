//
//  MenuController.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 10.09.2024.
//

import UIKit

protocol MenuControllerDelegate: AnyObject {
    func didTapMenuItem(indexPath: IndexPath)
}

class MenuController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate var menuItems = ["Saved Recipes", "Cookbooks", "Activity"]
    
    var menuBar: UIView = {
        let v = UIView()
        v.backgroundColor = ThemeColor.pinkButtonColor
        return v
    }()
    
    var delegate: MenuControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = ThemeColor.bgColor
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: MenuCell.identifier)
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }
        
        view.addSubview(menuBar)
        
        view.bringSubviewToFront(menuBar)
        
        menuBar.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(5)
            make.width.equalTo(ScreenSize.width / 3)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapMenuItem(indexPath: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.label.text = menuItems[indexPath.item]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        return .init(width: width/3, height: view.frame.height)
    }
}
