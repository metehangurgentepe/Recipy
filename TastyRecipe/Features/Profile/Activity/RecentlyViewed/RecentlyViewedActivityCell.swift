//
//  RecentlyViewedActivityCell.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 12.09.2024.
//

import UIKit

class RecentlyViewedActivityCell: UITableViewCell {
    
    enum Section {
        case main
    }

    static let identifier: String = "RecentlyActivityCell"
    var recipesArr: [Recipe] = []
    
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        createCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let height = 1170 / 150
        
        layout.itemSize = CGSize(width: 780 / height, height: 150)
        layout.minimumLineSpacing = 10
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RecentlyCell.self, forCellWithReuseIdentifier: RecentlyCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = ThemeColor.bgColor
        
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
    
    public func configure(recipes: [Recipe]) {
        self.recipesArr = recipes
        DispatchQueue.main.async{
            self.collectionView.reloadData()
        }
    }
}

extension RecentlyViewedActivityCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipesArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentlyCell.identifier, for: indexPath) as! RecentlyCell
        let model = recipesArr[indexPath.row]
        cell.configure(recipe: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        _ = recipesArr[indexPath.row].id
//        delegate?.didSelectRecipe(recipeId: id)
    }
}
