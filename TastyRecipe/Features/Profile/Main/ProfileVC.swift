//
//  ProfileVC.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 4.09.2024.
//

import UIKit

import UIKit

class ProfileVC: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    let menuController = MenuController(collectionViewLayout:  UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        setupLayout()
        setupCollectionView()
    }
    
    private func setupLayout() {
        let menuView = menuController.view!
        menuView.backgroundColor = .yellow
        
        view.addSubview(menuView)
        
        menuView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        
        collectionView.snp.makeConstraints { make in
            make.width.equalTo(view.frame.width)
            make.top.equalTo(menuView.snp.bottom)
            make.bottom.equalTo(view.snp.bottom)
            make.leading.equalToSuperview()
        }
    }
    
    private func setupCollectionView() {
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.height - 60 - 44 - UIApplication.shared.statusBarFrame.height)
    }
}
