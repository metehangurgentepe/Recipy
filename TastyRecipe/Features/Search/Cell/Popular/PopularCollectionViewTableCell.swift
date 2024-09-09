//
//  PopularCollectionViewTableCell.swift
//  TastyRecipe
//
//  Created by Metehan Gürgentepe on 6.09.2024.
//

import Foundation

import UIKit

class PopularCollectionTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    static let identifier = "PopularCell"
    
    var collectionView: UICollectionView!
    
    var popularItems = PopularModel.list
    weak var delegate: ButtonCollectionTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PopularCollectionViewCell.self, forCellWithReuseIdentifier: PopularCollectionViewCell.identifier)
        
        collectionView.backgroundColor = ThemeColor.bgColor
        
        contentView.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.identifier, for: indexPath) as! PopularCollectionViewCell
        let item = popularItems[indexPath.item]
        cell.configure(item: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let title = popularItems[indexPath.item]
        delegate?.buttonClicked(with: title.title)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalPadding: CGFloat = 10
        let itemWidth = ((collectionView.bounds.width - totalPadding) / 2)
        return CGSize(width: itemWidth, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
